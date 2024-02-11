---
title: "CZX: The ultimate Czech macOS keyboard layout"
---

Two years ago, sometime at the end of 2021, I got myself my first ever MacBook. Having always just looked from afar to the Apple land of computers, I knew very little on how to work with one, having spent 5+ years only using Windows.

When I began getting accustomed to my MacBook, it took me quite a while to figure out that there is no <kbd>Ctrl+C</kbd> and <kbd>Ctrl+V</kbd> and instead, I need to use the <kbd>Cmd</kbd> key for most of my keyboard shortcuts. In the end, this was not too difficult compared to the bigger challenge at hand: special symbols. When I first had to input my email address for my iCloud when setting the system up, I had no idea how to input an `@` symbol. On Czech Windows keyboard layouts, `@` hides under <kbd>AltGr+V</kbd> with `#` and `&` being the keys just next to it. I missed all of these on the macOS keyboard, while also having issues remembering where `{}` and `[]` hid. This led me to start researching what can be done about this, because at the time, I had no hopes of ever being able to learn another keyboard layout. 

I stumbled upon [an article](https://www.dajbych.net/ceska-klavesnice-pro-macos-i-pro-windows-vhodna-k-programovani) by Václav Dajbych, which addresses these exact issues with a custom keyboard layout. I started using his layout right away and have had very good experiences with it since. Last year, I finally gave in and began using the US layout - not only does it have some really nice coding-specific keybinds for the characters devs often use, but whenever I meet up with my colleagues IRL, they don't have to spend time adapting to a new layout. A new inconvenience hence arose - switching between the two layouts. Unfortunately, only using the US layout is impossible - the great accented letters of the Czech language are missing. It did not take long for my brain to always just hit the left <kbd>Fn</kbd> key when I needed those. 

When switching between the two layouts, the final problem was the fact the Czech one is QWERTZ while the US one is QWERTY. A layout I made based off of the one from the article, dubbed CZX, is therefore also QWERTY and additionally includes the Czech binding for the backtick: <kbd>⌥+7</kbd>.

You can grab the layout from my dotfiles repo [here](https://github.com/filiptronicek/dotfiles/blob/master/code.ty.keylayout).