---
title: "Cloudflare with the ECH again"
image: "cloudflare-with-ech-again.png"
---

Three months ago, I promised to _let you know_ if anything ever changes about the Cloudflare and <abbr title="Encrypted Client Hello">ECH</abbr> situation - and here we are. As of at least a couple weeks back, Cloudflare has been re-enabling ECH on all free tier websites. Just. Lovely.

It looks like I was also right in my guesses around the reasoning behind the initial disabling of ECH - [Cloudflare's official docs](https://developers.cloudflare.com/ssl/edge-certificates/ech/) now have an entire section called "Enterprise network applicability", aiming to document what companies can do to disable ECH on their networks (the tl;dr is that you just drop the `HTTPS` DNS record types from your corporate DNS resolver[^1]).

So, after nearly one year of my [initial ECH and ML-KEM blog](/hello-internet/), here is the updated table of adoption some arbitrarily chosen domains:

| Domain             | Protocol | Key exchange          | ECH support | Cloudflare? |
| ------------------ | -------- | --------------------- | ----------- | ----------- |
| `tiktok.com`       | TLS 1.3  | X25519                | No          | ❌          |
| `twitter.com`      | TLS 1.3  | X25519                | No          | ❌          |
| `github.com`       | TLS 1.3  | X25519                | No          | ❌          |
| `npmjs.com`        | TLS 1.3  | X25519Kyber768Draft00 | No          | ✅          |
| `cloudflare.com`   | QUIC     | X25519Kyber768Draft00 | No          | ✅          |
| `apple.com`        | TLS 1.3  | X25519                | No          | ❌          |
| `netflix.com`      | TLS 1.3  | X25519                | No          | ❌          |
| `vercel.com`       | TLS 1.3  | X25519                | No          | ❌          |
| `google.com`       | QUIC     | X25519Kyber768Draft00 | No          | ❌          |
| `instagram.com`    | QUIC     | X25519                | No          | ❌          |
| `shopify.com`      | TLS 1.3  | X25519Kyber768Draft00 | No          | ✅          |
| `drive.google.com` | QUIC     | X25519Kyber768Draft00 | No          | ❌          |
| `youtube.com`      | TLS 1.3  | X25519Kyber768Draft00 | No          | ❌          |
| `interclip.app`    | QUIC     | X25519Kyber768Draft00 | Yes         | ✅          |

Damn, besides Shopify and YouTube defaulting to TLS 1.3 instead of QUIC on Chrome now for some reason, literally nothing has changed when comparing to the table from October 2023 - no big domain I visit daily supports the Encrypted Client Hello goodness. We're still a long way from ECH being standard, so I guess, see you in 2025?

If we analyze the top 10 000 requested domains on Cloudflare, there is a significant number of them with ECH configured in their DNS. To my surprise, this included the very popular torrent trackers 1337x, KickassTorrents and BadassTorrents (although on second thought, these websites tend to be on Cloudflare's free tier, so it kind of makes sense). Some other notable adopters include:

- [curseforge.com](https://www.curseforge.com/)
- gitlab.io
- [jsdelivr.com](https://www.jsdelivr.com/)
- returnyoutubedislikeapi.com

Out of the 10 000, 349 domains have ECH enabled, which is a pretty ~3.5% starting adoption rate. Let's see if Cloudflare continues the rollout as promised and we begin to see adoption among the giants.

## Footnotes

[^1]: Of course, if you as an employee have access to the browser settings, you can just change your DNS resolver to a public one like Cloudflare's [1.1.1.1](https://one.one.one.one/) or Google's [8.8.8.8](https://developers.google.com/speed/public-dns/) to skip these restrictions.
