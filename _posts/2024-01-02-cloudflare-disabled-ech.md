---
title: "Cloudflare disables Encrypted Client Hello"
image: ciphertrails_2.png
---

In late October, [Cloudflare informed](https://community.cloudflare.com/t/early-hints-and-encrypted-client-hello-ech-are-currently-disabled-globally/567730) via their forum that they were disabling <abbr title="Encrypted Client Hello">ECH</abbr> on all sites they manage, due to "issues"[^1]. This is quite sad and surprising news, as ECH was a great step forward for privacy on the web and Cloudflare is the first big player driving adoption of the standard.

Hence, as of today, ECH is not enabled on **any** of the top 100,000 sites, as per the [Cloudflare Radar](https://radar.cloudflare.com/domains/) domain list. At least, if we're starting at 0, we can only go up from here.

Also, have a Happy New Year!

[^1]: Personally, I believe these to be political rather than technical in nature. As I wrote in the [first episode](/hello-internet/) of this series, networks with security policies can be easily worked around using ECH, and it also may be the case that those issues will need to be resolved first, before ECH can be rolled out to everyone.
