#!/bin/bash

# mkdir -p ~/.config/memo

# Bash
ln -s -f ~/dotfiles/.config/bash/.bashrc ~/.bashrc
ln -s -f ~/dotfiles/.config/bash/.bashenv ~/.bashenv
ln -s -f ~/dotfiles/.config/bash/.bash_profile ~/.bash_profile
ln -s -f ~/dotfiles/.config/bash/.inputrc ~/.inputrc
ln -s -f ~/dotfiles/.config/bash/.netrc ~/.netrc
# ln -s -f ~/dotfiles/.xinitrc ~/.xinitrc

# ZSH
ln -s -f ~/dotfiles/.config/zsh/.zshrc ~/.zshrc
ln -s -f ~/dotfiles/.config/zsh/.zshenv ~/.zshenv
ln -s -f ~/dotfiles/.config/zsh/.aliases ~/.aliases

# SSH/Telnet
ln -s -f ~/dotfiles/.config/.hushlogin ~/.hushlogin

# VIM
ln -s -f ~/dotfiles/.config/vim/.vimrc ~/.vimrc

# Terminal multiplexer
ln -s -f ~/dotfiles/.config/screen/.screenrc ~/.screenrc
ln -s -f ~/dotfiles/.config/tmux/.tmux.conf ~/.tmux.conf

# VCS
ln -s -f ~/dotfiles/.config/git/.gitconfig ~/.gitconfig
ln -s -f ~/dotfiles/.gitignore ~/.gitignore

# AG
ln -s -f ~/dotfiles/.config/ag/.agignore ~/.agignore

# python
ln -s -f ~/dotfiles/.config/python/pep8 ~/.config/pep8
mkdir -p ~/.config/pip
ln -s -f ~/dotfiles/.config/python/pip/pip.conf ~/.config/pip/pip.conf
mkdir -p ~/.config/matplotlib/
ln -s -f ~/dotfiles/.config/python/matplotlib/matplotlibrc ~/.config/matplotlib/matplotlibrc
mkdir -p ~/.config/pypoetry/
ln -s -f ~/dotfiles/.config/python/pypoetry/config.toml ~/.config/pypoetry/config.toml

# JS
ln -s -f ~/dotfiles/.config/npm/.npmrc ~/.npmrc

# Ruby
ln -s -f ~/dotfiles/.config/gem/.gemrc ~/.gemrc

# RStudio
mkdir -p ~/.config/rstudio/
ln -s -f ~/dotfiles/.config/rstudio/rstudio-prefs.json ~/.config/rstudio/rstudio-prefs.json

# GPG
mkdir -p ~/.gnupg/
ln -s -f ~/dotfiles/.config/gnupg/gpg-agent.conf ~/.gnupg/gpg-agent.conf

# WSL
sudo ln -s -f ~/dotfiles/.config/wsl/wsl.conf /etc/wsl.conf
sudo ln -s -f ~/dotfiles/.config/wsl/resolv.conf /etc/resolv.conf

# fish
mkdir -p ~/.config/fish/
ln -s -f ~/dotfiles/.config/fish/config.fish ~/.config/fish/config.fish
mkdir -p ~/.config/fish/conf.d/
ln -s -f ~/dotfiles/.config/fish/conf.d/* ~/.config/fish/conf.d/
mkdir -p ~/.config/fish/functions/
ln -s -f ~/dotfiles/.config/fish/functions/* ~/.config/fish/functions/
mkdir -p ~/.config/fish/settings/
ln -s -f ~/dotfiles/.config/fish/settings/* ~/.config/fish/settings/

sudo chmod 777 ~/.config/fish/settings/alias.fish
sudo chmod 777 ~/.config/fish/settings/basic.fish
sudo chmod 777 ~/.config/fish/settings/env.fish
