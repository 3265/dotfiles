#!/bin/bash

# mkdir -p ~/.config/memo

# Bash
ln -s -f ~/dotfiles/.bashrc ~/.bashrc
ln -s -f ~/dotfiles/.bashenv ~/.bashenv
ln -s -f ~/dotfiles/.bash_profile ~/.bash_profile
ln -s -f ~/dotfiles/.inputrc ~/.inputrc
ln -s -f ~/dotfiles/.xinitrc ~/.xinitrc
ln -s -f ~/dotfiles/.netrc ~/.netrc

# ZSH
ln -s -f ~/dotfiles/.zshrc ~/.zshrc
ln -s -f ~/dotfiles/.zshenv ~/.zshenv

# Alias
ln -s -f ~/dotfiles/.aliases ~/.aliases

# IME
ln -s -f ~/dotfiles/.xinputrc ~/.xinputrc

# Additional Shortcut Key
ln -s -f ~/dotfiles/.xbindkeysrc ~/.xbindkeysrc

# Keymap
ln -s -f ~/dotfiles/.xmodmap ~/.xmodmap

# Launcher
mkdir -p ~/.config/rofi
ln -s -f ~/dotfiles/.config/rofi/config ~/.config/rofi/config

# VIM
mkdir -p ~/.vim/
ln -s -f ~/dotfiles/.vimrc ~/.vimrc
ln -s -f ~/dotfiles/dein.toml ~/.vim/dein.toml
ln -s -f ~/dotfiles/dein_lazy.toml ~/.vim/dein_lazy.toml

# NVIM
mkdir -p ~/.config/nvim
ln -s -f ~/dotfiles/.vimrc ~/.config/nvim/init.vim

# i3 WM
mkdir -p ~/.config/i3
ln -s -f ~/dotfiles/.config/i3/config ~/.config/i3/config

# i3Status
mkdir -p ~/.config/i3status
ln -s -f ~/dotfiles/.config/i3status/config ~/.config/i3status/config

# Nofitication
mkdir -p ~/.config/dunst
ln -s -f ~/dotfiles/.config/dunst/dunstrc ~/.config/dunst/dunstrc

# Terminal
mkdir -p ~/.config/termite
ln -s -f ~/dotfiles/.config/termite/config ~/.config/termite/config

# MPD
mkdir -p ~/.config/mpd
ln -s -f ~/dotfiles/.config/mpd/mpd.conf ~/.config/mpd/mpd.conf

# Terminal multiplexer
ln -s -f ~/dotfiles/.screenrc ~/.screenrc
ln -s -f ~/dotfiles/.tmux.conf ~/.tmux.conf

# System monitor
ln -s -f ~/dotfiles/.conkyrc ~/.conkyrc

# VCS
ln -s -f ~/dotfiles/.gitconfig ~/.gitconfig
ln -s -f ~/dotfiles/.gitignore ~/.gitignore
ln -s -f ~/dotfiles/.tigrc ~/.tigrc

# Fusuma
mkdir -p ~/.config/fusuma
ln -s -f ~/dotfiles/.config/fusuma/config.yml ~/.config/fusuma/config.yml

# Docker
ln -s -f ~/dotfiles/.dockerignore ~/.dockerignore
# sudo ln -s -f ~/dotfiles/daemon.json /etc/docker/daemon.json # to use experimental future

ln -s -f ~/dotfiles/.agignore ~/.agignore
ln -s -f ~/dotfiles/.editorconfig ~/.editorconfig
# ln -s -f ~/dotfiles/config.toml ~/.config/memo/config.toml

# see https://askubuntu.com/questions/302736/solarized-color-name-not-defined
# ln -s -f ~/dotfiles/.Xresources  ~/.Xresources

# Compton
ln -s -f ~/dotfiles/.config/compton.conf ~/.config/compton.conf

# DB
ln -s -f ~/dotfiles/.my.cnf ~/.my.cnf

# GTK-3.0(for chromium)
mkdir -p ~/.config/gtk-3.0
ln -s -f ~/dotfiles/.config/gtk-3.0//settings.ini ~/.config/gtk-3.0/settings.ini

# peco
mkdir -p ~/.config/peco
ln -s -f ~/dotfiles/.config/peco/config.json ~/.config/peco/config.json

# polybar
mkdir -p ~/.config/polybar
ln -s -f ~/dotfiles/.config/polybar/config ~/.config/polybar/config
ln -s -f ~/dotfiles/.config/polybar/launch.sh ~/.config/polybar/launch.sh

# pet
mkdir -p ~/.config/pet
ln -s -f ~/dotfiles/.config/pet/config.toml ~/.config/pet/config.toml
ln -s -f ~/dotfiles/.config/pet/snippet.toml ~/.config/pet/snippet.toml

# ranger
mkdir -p ~/.config/ranger
ln -s -f ~/dotfiles/.config/ranger/rc.conf ~/.config/ranger/rc.conf

# GRC
mkdir -p ~/.grc/
ln -s -f ~/dotfiles/grc/grc.conf ~/.grc/grc.conf
ln -s -f ~/dotfiles/grc/conf.gotest ~/.grc/conf.gotest

# JS
ln -s -f ~/dotfiles/.npmrc ~/.npmrc
# ln -s -f ~/dotfiles/.tern-config ~/.tern-config

# Ruby
ln -s -f ~/dotfiles/.gemrc ~/.gemrc

# VS Code
ln -s ~/dotfiles/vscode/settings.json ~/.config/Code/User/settings.json
ln -s ~/dotfiles/vscode/keybindings.json ~/.config/Code/User/keybindings.json
ln -s ~/dotfiles/vscode/extensions.json ~/.config/Code/User/extensions.json
