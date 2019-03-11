---
date: 2016-11-29T19:09:21-08:00
draft: false
title: "HowTo Bind Multiple Terminals MacOS-X"
tags: [ technology, devops ]
---

## Binding Multiple Terminals

I am running on multiple servers all the time. And with DTAC doing testing of big data I obviously need to play with many servers at once. I used to do a lot of work on linux and loved the broadcast ability of the terminals. So when I moved onto mac I expected more.

I tried a few other terminal apps. Particularly [iTerm2](https://www.iterm2.com/documentation-one-page.html) that has some nice broadcasting. But I didn't like having to deal with the tabs and keystrokes. I kinda liked having multiple windows and the ease of launching with csshX


## csshX Installation

> csshX - Cluster SSH tool using MacOS-X Terminal.app

Installation is trivial.

  brew install csshx

See if you have a working copy

  csshx --help


## Configure csshX


Create a config file. I chose to set up an rc file in my home directory.

  touch ~/.csshrc

### Logging In With SSH Keys

You are going to need this. Pretty much all cloud servers require keys.

  csshx --login ubuntu --ssh_args "-i .ssh/your_private_key" host1 host2

That should get you pretty far.
