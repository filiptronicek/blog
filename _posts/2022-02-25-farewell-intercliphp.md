---
title: Farewell, IntercliPHP
---

Hi again! It's been a year already. Why not start the year off with some personal news, or rather some personal-**project** news?

As you may know, Interclip is a project I am very passionate about. More than [3 years have now passed](https://twitter.com/filiptronicek/status/1487539070733541382) since its inception, which makes me really happy and [makes me feel very very old](https://twitter.com/filiptronicek/status/1496581532630364160).

The whole time Interclip has been a thing, it has been running on Apache servers with good ol' PHP. This allowed me to really understand how web servers and browsers work, but it led to a few engineering challenges from a technical POV:
1. With an ever-growing codebase, it was really hard to manage components at such a low level, which also meant close to no IDE language smartness and frequent import errors.
2. JavaScript imports are something very frustrating when dealing with it on a vanilla-JS level. You have to import all packages through CDNs and it's a pain in the ass to upgrade them.
3. Something that I also learned by making desktop apps with Electron and mobile apps with React Native is that abstractions are awesome, if you choose the right ones. It is not a good idea to do input sanitization yourself, the same goes for authentication.
4. The project is a pain to get setup (without Gitpod) and therefore hard to contribute to. This is not something I like at all, anyone should be able to just see a function in the codebase and be sure of what it does, why it is there and where it is used.
5. JavaScript is not a very delightful language to use. TypeScript provides a much better experience and it is the standard for bigger projects.
6. I wanted to integrate Tailwind.css, but just couldn't. Purging doesn't work for vanilla PHP projects, which would mean a multiple megabyte style sheet file, which is unacceptable.

This and many other factors have driven me to experiment with all kinds of frameworks, but the one I settled on was Next.js. I really like this framework, because has a large community and has so many cool features baked right in. This helped me overcome all of the challenges from the list above and much more.

## My new toolbelt

### TypeScript

I am really trying to use as few `any` -s as possible and am [typing everything from events to API responses](https://github.com/interclip/next/tree/main/src/typings).

### ESLint

TypeScript code is not automatically clean and nice-looking code. Therefore, I maintain [a fairly extensive list of code style rules](https://github.com/interclip/next/blob/main/.eslintrc.json), which get automatically detected by the IDE and are tied into the CI process.

### Prisma

[Prisma](https://www.prisma.io/) is my [ORM](https://stackoverflow.com/a/1279678/10199319) of choice. It allows for extremely simple database interactions, which is something I always wanted: I hate writing SQL.

### Tailwind CSS

Tailwind allows me to maintain [a large set of independent components](https://github.com/interclip/next/tree/main/src/components), because I really care about every component being original, no [Bootstrap](https://getbootstrap.com/) or [Next UI](https://nextui.org/). This took the CSS footprint of the home page from 8.5KB to 6.07KB.

### Vercel

All tied in under Vercel's serverless platform I am able to have very well maintainable APIs, which are the same ones anyone can use to add Interclip to their app. Their cache is blazing fast and just awesome, although their Serverless functions can be painfully slow a lot of the time.

### Gitpod

Although it may not come as a surprise to you that Gitpod is on the list (I work there 😄), Gitpod is an awesome tool for the project, since I can fire a clean environment within a minute, with all of the latest dependencies and tools, whatever is it I am using to code it on.

## Limitations

There are some limitations to the current approach, including:

- Vercel's serverless functions are painfully slow, which means creating clips is not a pleasant experience
- JavaScript is required for Interclip working properly


<img width="873" alt="image" src="https://user-images.githubusercontent.com/29888641/155744177-bf9ec6aa-10ae-4327-abe2-642b01230952.png">


You can try the new version out over at [beta.interclip.app](https://beta.interclip.app/). please do report any bugs you fine, I know there is a lot of them :).
