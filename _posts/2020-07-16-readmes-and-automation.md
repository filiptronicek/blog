---
title: GitHub profile READMEs and how to get the most out of them
---

GitHub just introduced a new feature, profile READMEs. At first, they seem very simple, just a couple lines of simple markdown and you're all set. That's true for most, but not for me, and other GitHub users, who want to make their profiles stand out. I would highly encourage all of you to check out a list of the best picks at [abhisheknaiidu/awesome-github-profile-readme](https://github.com/abhisheknaiidu/awesome-github-profile-readme). My personal favorite is the README of [@timburgan](https://github.com/timburgan), where players can play an entire game of chess! I wanted to use GitHub Actions to make my profile README spicier, and at the end decided to do two main things:
* list my newest blog post
* display my newest tweet

## Creating the blog part
Handling markdown was a pretty big challenge with Python, I used no special libraries to handle it. Probably will tho in the future. I started with creating a script, that uses the GitHub API, to fetch all the files in my [blog repo](https://github.com/filiptronicek/filiptronicek.github.io), filters out everything else except files, that contain \_posts/ in their path.   
The files are named in this format:  `YYYY-MM-DD-name.md`. So we strip the date (```datetime.datetime.strptime(dateStr, "%Y-%m-%d")```), and parse it into a datetime Python object, so we can format it for display later.
We then GET the post, get the title from the second line of the meta-information, and store the blog URL, date, and the title in a dictionary. (the date is formatted in the `%B %-d, %Y` format.)
