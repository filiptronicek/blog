---
title: On a date with Interclip
---

Interclip has been getting a lot of updates recently, most prominently of all (and unbeknown to most) have been the changes on the server-side. I have upgraded the underlying architecture behind Interclip. I now have a much more powerful VM for faster operations and API calls. I have also moved the Database from an external webserver to a local one, nearly 10x its speed.
<blockquote class="twitter-tweet"><p lang="en" dir="ltr">Just made the Interclip API 10x faster, just because of a new DB. <a href="https://t.co/xEQBnuiUZu">pic.twitter.com/xEQBnuiUZu</a></p>&mdash; Φlip Tρnicek (@filiptronicek) <a href="https://twitter.com/filiptronicek/status/1354356645522976768?ref_src=twsrc%5Etfw">January 27, 2021</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
## Interclip
Alongside that, I have coded my first rate-limiter into Interclip ([#53](https://github.com/aperta-principium/Interclip/pull/53)), so that I would prevent some DOS attacks, and I have also coded a piece of code that deletes clips older than a month (any current clips are not affected), both features were shipped in [v3.2.4](https://github.com/aperta-principium/Interclip/releases/tag/v3.2.4). I fixed a ton of bugs and added a lot of more UI changes, all in versions from [v3.2.1](https://github.com/aperta-principium/Interclip/releases/tag/v3.2.1) to [v3.2.5](https://github.com/aperta-principium/Interclip/releases/tag/v3.2.5)

## Interclip mobile
I released [v0.2.2](https://github.com/filiptronicek/iclip-mobile/releases/tag/v0.2.2), which updates the API to v2 among some UI bug fixes. Interclip mobile is now on the Play Store, too! (App Store is coming soon, I just need to sort some things out).

## iclip-ext AKA Interclip in the browser
Use Chrome, Opera, Edge, Brave, Firefox, or any Chromium or Firefox-based browser? Now you can create clips easily with 1 click. I just thought ofo it one day in a Discord call with [@vlada_svoboda](https://twitter.com/vlada_svoboda) and I find it as a big time saver. So go download it! It's [open-source](https://github.com/aperta-principium/iclip-ext) as is the deal with close to everything I do nowadays.

![](https://trnck.dev/0:/uploads/ca962b70-d488-4c9c-ad08-3b1fab8e1354.png)

Download it on [Chrome](https://chrome.google.com/webstore/detail/interclip-extension/mpgjjbeepoonaaeaodiadghpnaadnngg) or [Firefox](https://addons.mozilla.org/en-US/firefox/addon/interclip/). Safari support coming perhaps in the following months.

## Interclip desktop
Because of Interclip's [APIv2](https://github.com/aperta-principium/Interclip/releases/tag/v3.2.0), Interclip's Desktop app has also been upgraded alongside some performance and stability updates. I will release v0.3.0 soon.
## embed.js
I made the code a lot easier to read and renamed the library from just Embed to embed.js. It also now proxies all of its embeds through [iclip-external](https://github.com/filiptronicek/iclip-external/).

<hr>
Also, that ugly [http://uni.hys.cz](http://uni.hys.cz) is now [https://interclip.app](https://interclip.app), thanks, [sponsors](https://thanks.trnck.dev/)! [[Deprecation tweet](https://twitter.com/filiptronicek/status/1355504669263613953?s=20)]

Thanks for the two years together, guys <3


![](https://trnck.dev/0:/uploads/7187bba4-30d0-4733-b600-94c55f1565b8.png)
