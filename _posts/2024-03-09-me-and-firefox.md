---
title: "Me and Firefox"
layout: post
---

Firefox is a browser, I think we can all agree. I would go as far as to say that it's a _good_ browser. It's not perfect, but I found that it's as good as it gets when considering open-source browsers that "just work". Using a browser that is aligned with your moral and ethical stances comes at a cost, though.

When [Passkeys](https://developers.google.com/identity/passkeys) first started rolling out, I wanted to use them everywhere. I began using them for my personal and work Google Accounts, GitHub, GitLab, Cloudflare and everywhere else that supported them. As we already know, in the browser world, it always takes (at least) two to tango: not only did GitHub have to support Passkeys, but my browser had to as well. And it didn't. I set up all of my Passkeys through Safari because, at the time, even Chrome forced users into the although technically impressive, extremely obnoxious QR code sign-in. So, when Chrome made the iCloud keychain natively integrated, I felt like I could not wait any longer for it to ship on Firefox. I switched to Chrome.

At the time, I used to use Firefox Nightly as my default browser, so I opted for using Chrome Canary as Google's latest release channel. It was a terrible idea. I experienced crashes on a daily basis and so many weird page behaviors. I switched to Brave. Brave is fun and is what I've been using about 2 years ago prior to originally switching to Firefox, but the fun did not have to last long. On the 12th of December 2023, the [word got out](https://x.com/rmondello/status/1734585272824639566?s=20) about Firefox shipping passkeys. It made my week.

I switched to using Firefox again, and at the time of writing, I am still happy with it, even though it sometimes slightly misbehaves. I've been extremely excited about them shipping support for other standards, such as X25519Kyber768Draft00 and cool features like [tab previews](https://blog.nightly.mozilla.org/2024/02/06/a-preview-of-tab-previews-these-weeks-in-firefox-issue-153/). That being said, I feel like whenever I try to have my fun with some cool Web APIs, Firefox disappoints me. I always thought Safari would be the slowest to adopt these, but to my surprise, recently, quite the opposite has been happening. Some recent examples of things I dearly miss:

- P3 color support (https://bugzilla.mozilla.org/show_bug.cgi?id=1686431)
- HDR image and video support (https://bugzilla.mozilla.org/show_bug.cgi?id=hdr)
- The vibrationActuator method for Gamepads (https://bugzilla.mozilla.org/show_bug.cgi?id=1824217)
- Proper navigator.clipboard.\* APIs support ([Browser Compat table](https://developer.mozilla.org/en-US/docs/Web/API/Clipboard#browser_compatibility))

At the end of the day, web developers can never really only use one browser. I will be trying out the latest and greatest features wherever they come out first. Cheers to the awesome work the team at Mozilla is doing! Let's see where this year takes us.

