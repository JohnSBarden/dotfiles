# Dotfiles

These dotfiles were originally David Duncan's, and you can choose to pull them down as is and base your dotfiles off of them, or you can fork this project, and modify them as you will.

You do not need these dotfiles, but they ensure that you have a great terminal/development environment setup, no matter what box you are using.

## Overview of what is packaged:

Shell: zsh, with package manager antigen and lots of great plugins pre-installed
WM/DM: i3
Editor: vim/neovim 'dark-powered' configuration
Other: awscli, kubectl, stern, peco, golang, microsoft teams, jetbrains toolbox, rofi/modi for wm searching, and more

## Installation

yadm is used to easily manage the installation and bootstrapping. yadm is basically a wrapped around git, and transparently manages a git repository in your $HOME directory, without including everything inside of it automatically

```sh
sudo apt install yadm git
yadm clone git@gitlab.intellifarms.com:ifp/tools/dotfiles.git

OR - if you forked this repository, provide the repository url of the fork

```

## Getting updates

```sh
yadm pull --ff
```

## Commiting updates

```sh
yadm checkout -b my-branch-name
yadm add file-that-changed
yadm commit -am 'feat: add new feature'
yadm push origin master
```
