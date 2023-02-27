---
title: All the time(ly) matters
---

Hi folks, it's me here again. Today I want to focus on an OSS product I launched in mid-December 2020, CountDowner. It is a really simple service for, well, counting down to dates. It was so simple to code in fact, that it took me about 2 hours to get it entirely working and ready to be published (most work is done in [dd926c7](https://github.com/filiptronicek/CountDowner/commit/dd926c7afab66beb39d37b096b3b4ee1de9839b1)). This year, I wanted to focus on making it a more usable and sustainable from the developer side. First, I needed to redesign the create page, which I did with [js-datepicker](https://www.npmjs.com/package/js-datepicker) and the native [time-picker](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/time) component. I also rewrote the code to use Webpack, because it should be faster and easier to integrate new libraries.

## Synchronizing time and the impossibility of it

In [CountDowner#14](https://github.com/filiptronicek/CountDowner/pull/14/), I introduced a function that would synchronize the time with the help of a serverless function, which would just return the current UNIX timestamp and (if provided) the difference between the current and the provided timestamp. 

I chose Cloudflare workers for this because Vercel has an issue in both being slower in execution and having cold starts - sometimes reaching latencies of 200+ ms, which is not acceptable when working with precise time[^1]. The problem is, that even with Cloudflare's faster serverless infrastructure, the ping was still sometimes 50+ ms and I needed to account for that. 

You can easily subtract the roundtrip time from the returned time difference, but that would also account for the ping back, which we don't care about. In my implementation, we just assume that the round trip takes the same time to the server and back, so I just divide the ping in half and subtract that[^2]. If there was a better way, I would implement it, but it just cannot be done. There is a great article about the hardships of time synchronization by [Craig Gidney](https://web.archive.org/web/20221009072312/http://twistedoakstudios.com/blog/Post2353_when-one-way-latency-doesnt-matter)[^3], which I can only recommend. 

![Diagram of the Cloudflare worker](https://trnck.dev/0:/img/d69f61a0-cf86-4666-8cda-cb8cbda45282.svg)

[^1]: You wouldn't want to celebrate your birthday 200 milliseconds in advance now, would you?
[^2]: This assumption is pretty alright with good networking conditions, but gets very bad when dealing with high latency connections (e.g. satellite internet, cellular networks, Tor, VPNs).
[^3]: Not exactly about syncing UNIX time stamps, but roughly the same problem is touched on by Derek Muller in his video [Why No One Has Measured The Speed Of Light](https://www.youtube.com/watch?v=pTn6Ewhb27k)
