---
title: Coding in the cloud (GitHub Codespaces vs. Gitpod)
---

> Please do not read this article. I had no idea what I was talking about back in 2020. There are a lot of false, misleading and outdated comments about both GitHub & Gitpod, so please read [Gitpod's Codespaces vs Gitpod comparison](https://www.gitpod.io/vs/github-codespaces) instead. 

## GitHub Codespaces

Codespaces are awesome. They are one of the coolest GitHub products in my opinion. They offer a very familiar experience to VS Code and GitHub. 
* (+) All your VS Code stuff gets synced
* (+) You can use all the VS Code keyboard shortcuts
* (+) You can have setup scripts with a dotfiles repo (see [mine](https://github.com/filiptronicek/dotfiles) for some inspiration)
* (-) You only get about 4 GB of RAM (should be enough in most circumstances though)
* (-) You are limited to 5 active Codespaces

## Gitpod

Gitpod is quite a nice alternative to Codespaces. With their browser extension, it is fairly simple to open a repo in your browser and start working. I am running the Jekyll Admin server on Gitpod for writing this article!

* (+) You get a whopping 60 GB of RAM
* (+) You can install your extensions just for a single project, or for your whole account
* (+) You can have as many projects as you want, but they will be deleted after 10 days of inactivity (shouldn't generally be a problem)
* (-) You can download a limited amount of extensions
* (-) You have to enable autosave for every project manually
* (-) There is a timeout for the IDE
