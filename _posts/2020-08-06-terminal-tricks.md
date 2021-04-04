---
title: Perfecting the Windows Terminal
---

The Windows Terminal is the program, which all devs missed in Windows for years. Now it's here and it's awesome! In this post, I'll share some tips for customizing it.

## 1) PowerShell Core
PowerShell is the default shell in the Terminal, and there is now a multiplatform and open source version of it called PowerShell Core. It's not that much different from PowerShell, but it has such an awesome icon.
![PowerShell core icon](https://dev-to-uploads.s3.amazonaws.com/i/zxvi6tz9r3zsw04lklh9.png)

Download it from [GitHub](https://github.com/PowerShell/PowerShell/releases/latest) or just `choco install powershell-core`

## 2) WSL 2
You can have Linux in the Terminal, too! Just download Ubuntu, Alpine, Debian, or Kali from the Microsoft Store (more distros are in the works).

With the introduction of Windows Subsystem for Linux version 2, you can do even more, because of the deeper integration of Linux into the Terminal. You can even have a GUI!

You can have a lot of them running at once, just like this:
![Desktop setup with multiple tabs](https://trnck.dev/0:/img/sahg20mu4nkkhlexnlqj.jpg)

## 3) Terminal Settings
At the end of the previous chapter, you saw an image of my current setup of the Terminal. As you can see, you can have custom fonts, icons, and backgrounds. All of this can be achieved by editing the settings.json of the Terminal. You can get there by hitting `Ctrl + ,` or selecting "Settings" in the dropdown menu, you can directly edit the JSON powering your Terminal layout. If you want to see everything you can do here, take a look at the [Microsoft Docs](https://docs.microsoft.com/en-us/windows/terminal/customize-settings/profile-settings). The most important thing is, that you can set settings for both default shells and specific ones. Each shell has a GUID, which is a unique identifier of the shell. You can further specify a name, an icon, and whether to show it or not. This can result in something like this: 
```json
{
    "guid": "{2c4de342-38b7-51cf-b940-2309a097f518}",
    "hidden": false,
    "name": "Ubuntu",
    "source": "Windows.Terminal.Wsl",
    "icon": "https://files.catbox.moe/xpptug.png"
},
```

You can also set to use acrylic (the transparent background) or use a different font. An awesome font for the Terminal is [Cascadia Code PL](https://github.com/microsoft/cascadia-code/releases) (it includes some little icons for themes and such)
An example of this can be something like this:
```json
"defaults": {
     "fontFace": "Cascadia Mono PL",
     "useAcrylic": true
}
```

## 4) Panes
Not only can you have a lot of tabs open, but you can also have two panes with the same shell at once! You can bind that to any shortcut you want, but I like to use `Alt + Shift + D`. You can configure this again in your settings.json file mentioned above. In the keybindings section, paste this:
```json
{
 "command": { 
    "action": "splitPane", 
    "split": "auto",
    "splitMode": "duplicate"
 }, "keys": "alt+shift+d" 
}
```

## 5) Sudo mode with gsudo
You can use Escalated privileges mode using the Chocolatey package gsudo (`choco install gsudo`)
This can be used for example for using Chocolatey because it needs admin privileges to run properly.

For this specific example of Chocolatey, type `notepad $Profile` in the Powershell and add the following line to it:
`function choco { gsudo choco @args }`

## My config
My Terminal config is publicly accesible in a [GitHub Gist](https://gist.github.com/filiptronicek/92a68c8b21f0f317d6995fe2f7467524), feel free to edit or do anything else with it.
