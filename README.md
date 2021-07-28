# Get started building your personal website
[![Codeship Status for filiptronicek/filiptronicek.github.io](https://app.codeship.com/projects/4c810410-9f75-0138-4653-6678402409b7/status?branch=master)](https://app.codeship.com/projects/401750)

![](https://user-images.githubusercontent.com/221550/110506678-51906280-80cd-11eb-803a-c41984bd9312.png)

## Installation

### Install in your local development environment

If you want to manage your website in a local web development environment, you'll be using [Ruby](https://jekyllrb.com/docs/installation/).

Once you've found a home for your forked repository, **[clone it](https://help.github.com/articles/cloning-a-repository/)**.

#### Install Jekyll

Jekyll is a [Ruby Gem](https://jekyllrb.com/docs/ruby-101/#gems) that can be installed on most systems.

1. Install a full [Ruby development environment](https://jekyllrb.com/docs/installation/)
2. Install Jekyll and [bundler](https://jekyllrb.com/docs/ruby-101/#bundler) [gems](https://jekyllrb.com/docs/ruby-101/#gems)
```
gem install jekyll bundler
```
3. Install missing gems
```
bundle install
```
4. Build the site and make it available on a local server
```
bundle exec jekyll serve
```
### Publish

When you host your personal website's code on GitHub, you get the support of free hosting through GitHub Pages.

**The fastest approach** is to rename your repository `username.github.io`, where `username` is your GitHub username (or organization name). Then, the next time you push any changes to your repository's `master` branch, they'll be accessible on the web at your `username.github.io` address.

**If you want to use a custom domain**, you'll want to add it to your repository's "Custom domain" settings on github.com. And then register and/or [configure your domain with a DNS provider](https://help.github.com/articles/quick-start-setting-up-a-custom-domain/).

The theme is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
