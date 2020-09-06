# Overview
This dotfile repository will contain configuration for the following tools:

- [x] Bash
- [x] ZSH
- [x] tmux
- [x] git
- [ ] vim
- [x] gnupg
- [x] screen

## Build Status
Dotfiles and the installation process detailed in the this repository are tested with a docker container and an automated build. The status of the build is shown below:

[![Build Status](https://travis-ci.org/brutalgg/dotfiles.svg?branch=master)](https://travis-ci.org/brutalgg/dotfiles)

# Installation
**Warning:** Use these dotfiles at your own risk. These will overwrite some 
operating system default settings.

## Git and bootstrap

You can clone the repository wherever you want. (I like to keep it in ~/Projects/dotfiles, with ~/dotfiles as a symlink.) The bootstrapper script will pull in the latest version and copy the files to your home folder.

```bash
git clone https://github.com/brutalgg/dotfiles.git && cd dotfiles && source bootstrap.sh
```

## Specify the $PATH
If ~/.path exists, it will be sourced along with the other files, before any feature testing (such as detecting which version of ls is being used) takes place.

Here’s an example ~/.path file that adds /usr/local/bin to the $PATH:

```bash
export PATH="/usr/local/bin:$PATH"
```
