---
title: "Kyber kexes"
image: ciphertrails_3.png
---

It's been a while since we last took a look at the two new promising technologies on the web - post-quantum key exchange with Kyber[^1] and <abbr title="Encrypted Client Hello">ECH</abbr>, so it makes sense to revisit them and see what's up.

## Kyber

For securing our modern internet traffic against [Harvest now/Decrypt later](https://en.wikipedia.org/wiki/Harvest_now,_decrypt_later) attacks, we have seen quite nice adoption of X25519Kyber512Draft00 and X25519Kyber768Draft00 globally. Thanks to increased support with recent additions to tools like [Firefox](https://x.com/bwesterb/status/1748017372764475519) or [rustls](https://docs.rs/rustls-post-quantum/latest/rustls_post_quantum/) and Chrome 124 enabling Kyber by default, much of the world's internet traffic is now secure against quantum adversaries. According to [Cloudflare Radar](https://radar.cloudflare.com/adoption-and-usage?dateRange=52w), Kyber is now used in 17.6% of connections going through Cloudflare's network, which is only expected to increase[^2]. The big puzzle piece missing here is support in Safari, which is responsible for about 15% of the web traffic.

Of course, this is mostly thanks to most of the most-visited websites either being operated by Google or proxied by Cloudflare. For independently operated websites and services, even if hosted on public clouds, the key to adoption is inclusion in proxy software like Nginx, Apache, or Caddy[^3], as well as people simply updating their browsers.

## ECH

Unfortunately, despite being around since all the way in 2018 (then known as <abbr title="Encrypted server name indication">ESNI</abbr>) and hence being a lot older than Kyber, ECH is still not really used anywhere. Since last October, Cloudflare [has disabled](/cloudflare-disabled-ech/) ECH on all of their customers' websites for “reasons”. Although both Chrome and Firefox support the technology and are very happy to utilize it (we even [got support](https://github.com/golang/go/issues/63369) for it in Go), the only place you will bump into it is on testing websites like [defo.ie](https://defo.ie/ech-check.php) or Cloudflare's [encryptedsni.com](https://encryptedsni.com). If this ever changes, you can be sure to read about it here, because I personally believe this to be one of the most interesting and important developments in TLS in the last decade.

## Additional tidbits

- If you operate a website and would like to check its support for Kyber and ECH, you can use the [ech-check](https://github.com/filiptronicek/ech-check) CLI tool I wrote for this purpose.
- A very nice report on how things are going in the <abbr title="Post-quantum cryptography">PQC</abbr> world is Bas Westerbaan's piece [The state of the post-quantum Internet](https://blog.cloudflare.com/pq-2024)

Thanks for sticking around; see ya next time!

## Footnotes

[^1]: Since [last time](/hello-internet), Kyber has been renamed to [ML-KEM](https://csrc.nist.gov/pubs/fips/203/ipd), but for the purposes of this post, I will keep calling it Kyber, because both of its derived key exchanges use that name.
[^2]: This number gets even more impressive when you take into account that when part one of this series was published, Kyber was only used in 0.2% of connections.
[^3]: If you want to try Caddy or nginx with Kyber today, there are guides provided for both: [Caddy](https://gist.github.com/bwesterb/2f7bfa7ae689de0d242b56ea3ecac424) and [nginx](https://blog.centminmod.com/2023/10/03/2860/how-to-enable-cloudflare-post-quantum-x25519kyber768-key-exchange-support-in-centmin-mod-nginx/).
