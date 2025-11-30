---
title: "Instant Messaging apps: an overview of Discord, Signal and Matrix"
---

As part of [4IZ110](https://4iz110.vse.cz/) at my bachelor's programme at the Prague University of Business and Economics, I chose the topic of Instant Messaging for my term paper. In it, I wanted to focus on three distinct approaches to instant messaging today:

- Centralized without <abbr title="End-to-End Encryption">E2EE</abbr>, where I chose Discord as a well-known example
- Centralized with E2EE: this was represented by the Signal protocol, which powers apps like Signal, WhatsApp or Messenger
- Decentralized with E2EE: the example given in the term paper is the federated Matrix protocol

I chose to focus mainly on the encryption and data formats behind these protocols, as I thought the three would make an interesting comparison. Learning about how Signal does key derivation and how it can guarantee both forward secrecy and post-compromise security, my mind was truly boggled (in other words, I learned a lot).

You can find the thesis as PDF [in Czech] [here](/static/Instant%20Messaging.pdf).

The scope of the paper sadly limited the space to dive too deep into all of the protocols, but I was at least glad I was able to connect instant messaging with my love for <abbr title="Post-Quantum">PQ</abbr> cryptography – not only was I able to talk about <abbr title="Post-Quantum Extended Diffie-Hellman">PQXDH</abbr>, the quantum-resistant key agreement protocol we briefly touched on [more than 2 years back](/hello-internet/), but as it turns out, there is a new way the brilliant engineers behind the Signal messenger created to make messaging even more complex.

## Addendum 1: The Triple Ratchet

As Signal outlined in [their blog post](https://signal.org/blog/spqr/) from early October, PQXDH is cool 'n all, but does not address the full scope of post-quantum cryptographic problems with the Signal protocol: one of its core guarantees, post-compromise security, can be broken if the attacker can break <abbr title="Elliptic-curve Diffie–Hellman">ECDH</abbr>.

The team designed a way to use the ML-KEM 768 standard with a concept of epochs, where each epoch between Alice and Bob (our two chatty friends) starts when they agree on a shared secret and mix it into their conversation's encryption key. This shared secret is based on Alice's asymmetric keypair and Bob's generated secret. Whenever a new epoch starts, the protocol guarantees both forward secrecy (no one who compromises the conversation today can decrypt messages from the last epoch) and post-compromise security (compromising the keys of one side of the conversation today will not help you decrypt the next epoch).

The Sparse Post-Quantum Ratchet, as the team calls it, offers two very important attributes:

- At least as secure as double ratcheting: the SPQR is an additional ratcheting mechanism running besides the Double Ratchet. Keys from both ratchets are then mixed together with a <abbr title="Key Derivation Function">KDF</abbr> so that they don't accidentally create a big security hole in their messaging app with a new encryption scheme
- The per-message key material size isn't much different from the Diffie-Hellman ratchet of 32 bytes per message [^1]. The 1184 bytes for the initial encapsulation key are not sent all at once by Alice, but in chunks, each delivered with every message to Bob.
  - The chunks are split using Reed–Solomon erasure codes, which guarantee that if you need `n` chunks to construct the entire ML-KEM <abbr title="Encapsulation Key">EK</abbr>, you can do so with _any_ `n` chunks from a chunk stream, no matter the order or whether the stream is continuous. The same goes for sharing the resulting ciphertext from Bob back to Alice.

The algorithm is also optimized for efficiency: sharing a large key chunk-by-chunk is a very one-sided operation, so the Signal team took advantage of how ML-KEM keys are structured: because most bytes of the large key are just used for describing the lattice structure of the key, we can initially just send a small portion (a 32 byte seed for our lattice space generation and a 32 byte hash of `EK`) for the other side to be able to construct the majority of the final ciphertext (`CT`), so that we can start doing ping-pong earlier (and conversely, get a shared secret sooner and start more epochs more often).

The Signal team is rolling this out to conversations in their messenger app right now, and will start working when both devices have an up-to-date version of Signal[^2].

## Footnotes

[^1]: The encapsulation key size of ML-KEM reaching over a kilobyte has been a problem ever since the <abbr title="Key Exchange">KEX</abbr> algorithm was first introduced into the networking stack: because these keys do not fit into a single packet, they've caused incompatible servers to fail quantum-secure connections. This problem even has a [website](https://tldr.fail/)!
[^2]: Although the SPQR was introduced in [libsignal v0.74.0](https://github.com/signalapp/libsignal/releases/tag/v0.74.0) in early June, it started rolling out some time after [August 20](https://github.com/signalapp/Signal-iOS/commit/636875907b3325746ae9aef19cfdc4f4a7d02298).
