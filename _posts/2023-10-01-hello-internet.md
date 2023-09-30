---
title: "Unveiling the Early Adopters of ECH and Kyber"
image: "ciphertrail-chronicles.jpg"
---

As we are already pretty used to, the web gets more secure every single day. This time around we are talking about two new emerging standards: Kyber-based hybrid post-quantum key exchange and <abbr title="Encrypted Client Hello">ECH</abbr>. Both of these are currently "Active Internet-Draft"s, but they have already begun to roll out to major sites, at least one of them.

Let's start with Kyber. Now that we have quantum computers and their qubits are [ever increasing](https://www.ibm.com/quantum/roadmap), we need to start thinking about protecting our quantum-vulnerable encryption algorithms against them. Fortunately, this neither means that your data is at risk now or that we need to replace all cryptography at use today. The algorithms vulnerable to quantum computers implementing Shor's algorithm are the ones used for key exchange, the part of an encrypted communication responsible for setting up a shared key. The biggest ones we're aiming to replace are <abbr title="Diffie-Hellman">DH</abbr>, <abbr title="Elliptic Curve Diffie-Hellman">ECDH</abbr>, and RSA.

<abbr title="The National Institute of Standards and Technology">NIST</abbr> is on track to standardize the Lattice-based CRYSTALS-Kyber algorithm as a replacement to the aforementioned vulnerable ones by 2024. Some clever engineers have already begun with real-world implementations: Signal [recently announced](https://signal.org/blog/pqxdh/) their spin on the soon-to-be standard, Post-Quantum Extended Diffie-Hellman or PQXDH for short. The update to the Signal protocol features a hybrid[^1] between the KEM in use today, X25519 (ECDH), **and** CRYSTALS-Kyber for a simple reason: it is not a good idea to trust the latest standards when it comes to encryption — they're often broken[^2], but never on day 1. This a very similar approach to the one the latest post-quantum hybrid key agreement algorithms for TLS take: both X25519Kyber512Draft00 and X25519Kyber768Draft00 feature the same algorithms (X25519 + Kyber), which major players including Google and Cloudflare have been beta testing for over a year now. [[1](https://blog.cloudflare.com/post-quantum-for-all/)]

This means that most sites proxied through Cloudflare already support Kyber512 and Kyber768 key agreements. The list also includes Google-owned sites like YouTube and Google Drive, but to find Amazon or Microsoft's sites, you'd have to look elsewhere. Adoption is rolling out slowly but surely, but the bigger issue here are the clients: only the latest of Chrome supports it[^3], with other clients like `curl` and most programming language's network APIs still lacking any progress — most likely, we will have to wait until finalization of the [proposal](https://www.ietf.org/archive/id/draft-westerbaan-cfrg-hpke-xyber768d00-00.html) for further adoption.

Next is up ECH, which is solving an issue of the present. As you may know, technologies like [DoH](https://en.wikipedia.org/wiki/DNS_over_HTTPS) and [TLS](https://en.wikipedia.org/wiki/Transport_Layer_Security) help to keep snoopers away from your network traffic. The last piece of the puzzle is ClientHello, the packet responsible for negotiating a TLS session, which contains information including the <abbr title="Server Name Indication">SNI</abbr>, describing the hostname the client is requesting a certificate for. This meant that, for anyone listening for packets traveling over the network (be that your place of work, school or the ISP in case of your own home) they could see all of the domains you were visiting. With Encrypted Client Hello, the SNI is encrypted (the encrypted part is called _inner ClientHello_) and only the common name (SNI) is requested in plaintext (_outer ClientHello_).

| Without ECH                            | With ECH                                 |
| -------------------------------------- | ---------------------------------------- |
| ![image](/img/ciphertrail/no_ech.webp) | ![image](/img/ciphertrail/with_ech.webp) |

To summarize, ECH is a great feature for improving online privacy for many, the need to use a VPN (for personal use). It has great support among browsers, with both Chrome and Firefox leading the way[^4]. Client support is awesome to see, but in this case, we have an opposite problem to the one of Kyber PEMs: virtually no service accepts encrypted client hellos. I can only speculate about why I think that is: my opinions range from "c'mon, this was literally [released yesterday](https://blog.cloudflare.com/announcing-encrypted-client-hello/)" to the fact that this has big implications on security policies in enterprise and in places like schools, where some websites tend to be blocked. On the latter, the [Encrypted Client Hello Deployment Considerations](https://datatracker.ietf.org/doc/draft-campling-ech-deployment-considerations/) document explains these caveats in detail.

Personally, I hold ECH for a massive improvement to the overall digital landscape and would encourage anyone on Cloudflare to [flip the switch](https://dash.cloudflare.com/?to=/:account/:zone/ssl-tls/edge-certificates). For other providers, I'd wait until ECH becomes easily available for you.

I would love to make a blog post series out of this concept of web security, I named it "CipherTrail Chronicles" and hope I to see you on episode 2. To close of the post on something informative, here is an overview of some notable domains and their support status (as of September 2023)[^5]:

| Domain             | Protocol | Key exchange          | ECH support | Cloudflare? |
| ------------------ | -------- | --------------------- | ----------- | ----------- |
| `tiktok.com`       | TLS 1.3  | X25519                | No          | ❌           |
| `twitter.com`      | TLS 1.3  | X25519                | No          | ❌           |
| `github.com`       | TLS 1.3  | X25519                | No          | ❌           |
| `npmjs.com`        | TLS 1.3  | X25519Kyber768Draft00 | No          | ✅           |
| `cloudflare.com`   | QUIC     | X25519Kyber768Draft00 | No          | ✅           |
| `apple.com`        | TLS 1.3  | X25519                | No          | ❌           |
| `netflix.com`      | TLS 1.3  | X25519                | No          | ❌           |
| `vercel.com`       | TLS 1.3  | X25519                | No          | ❌           |
| `google.com`       | QUIC     | X25519Kyber768Draft00 | No          | ❌           |
| `instagram.com`    | QUIC     | X25519                | No          | ❌           |
| `shopify.com`      | QUIC     | X25519Kyber768Draft00 | No          | ✅           |
| `drive.google.com` | QUIC     | X25519Kyber768Draft00 | No          | ❌           |
| `youtube.com`      | QUIC     | X25519Kyber768Draft00 | No          | ❌           |
| `interclip.app`    | QUIC     | X25519Kyber768Draft00 | Yes         | ✅           |

References:

- [X25519Kyber768Draft00 hybrid post-quantum KEM for HPKE](https://www.ietf.org/archive/id/draft-westerbaan-cfrg-hpke-xyber768d00-00.html)
- Some of the domains taken from Cloudflare Radar's [Top 100 domains](https://radar.cloudflare.com/domains/) (on 09/30/2023) 
- PQXDH: https://signal.org/docs/specifications/pqxdh/
- [ECH protocol on Cloudflare's Docs](https://developers.cloudflare.com/ssl/edge-certificates/ech/)

[^1]: Hybrid means that it is a combination of two algorithms. This implies double-encryption of all data, meaning that the key agreement can only be so weak as is its strongest component.
[^2]: [It](https://eprint.iacr.org/2022/214.pdf) [really](https://eprint.iacr.org/2022/975) [does](https://csrc.nist.gov/CSRC/media/Projects/Post-Quantum-Cryptography/documents/round-1/official-comments/guess-again-official-comment.pdf) [happen](https://arxiv.org/abs/1805.05429), [a](https://arstechnica.com/information-technology/2022/08/sike-once-a-post-quantum-encryption-contender-is-koed-in-nist-smackdown/) [lot](https://groups.google.com/a/list.nist.gov/g/pqc-forum/c/KRh8w03PW4E).
[^3]: Although only X25519Kyber768Draft00 is supported in Chrome
[^4]: The only notable omission here is Safari and iOS / iPadOS in general.
[^5]: Tested on Chrome 117.0.5938.62 with both ECH and Kyber flags enabled.

