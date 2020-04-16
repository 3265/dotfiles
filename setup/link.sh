#!/bin/bash

# mkdir -p ~/.config/memo

# Bash
ln -s -f ~/dotfiles/.bashrc ~/.bashrc
ln -s -f ~/dotfiles/.bashenv ~/.bashenv
ln -s -f ~/dotfiles/.bash_profile ~/.bash_profile
ln -s -f ~/dotfiles/.inputrc ~/.inputrc
# ln -s -f ~/dotfiles/.xinitrc ~/.xinitrc
ln -s -f ~/dotfiles/.xprofile ~/.xprofile
ln -s -f ~/dotfiles/.netrc ~/.netrc

# ZSH
ln -s -f ~/dotfiles/.zshrc ~/.zshrc
ln -s -f ~/dotfiles/.zshenv ~/.zshenv

# Alias
ln -s -f ~/dotfiles/.aliases ~/.aliases

# IME
# ln -s -f ~/dotfiles/.xinputrc ~/.xinputrc

# Additional Shortcut Key
ln -s -f ~/dotfiles/.xbindkeysrc ~/.xbindkeysrc

# Keymap
ln -s -f ~/dotfiles/.xmodmap ~/.xmodmap

# Launcher
mkdir -p ~/.config/rofi
ln -s -f ~/dotfiles/.config/rofi/config ~/.config/rofi/config

# VIM
ln -s -f ~/dotfiles/.vimrc ~/.vimrc

# NVIM
mkdir -p ~/.config/nvim
ln -s -f ~/dotfiles/.vimrc ~/.config/nvim/init.vim

# VIM & NVIM PKG
mkdir -p ~/.vim/
ln -s -f ~/dotfiles/.config/vim/dein.toml ~/.vim/dein.toml
ln -s -f ~/dotfiles/.config/vim/dein_lazy.toml ~/.vim/dein_lazy.toml

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

# Alacritty
mkdir -p ~/.config/alacritty
ln -s -f ~/dotfiles/.config/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml

# MPD
mkdir -p ~/.config/mpd
ln -s -f ~/dotfiles/.config/mpd/mpd.conf ~/.config/mpd/mpd.conf

# Terminal multiplexer
ln -s -f ~/dotfiles/.screenrc ~/.screenrc
ln -s -f ~/dotfiles/.tmux.conf ~/.tmux.conf

# Conky
mkdir -p ~/.config/conky
ln -s -f ~/dotfiles/.config/conky/conky.conf ~/.config/conky/conky.conf

# VCS
ln -s -f ~/dotfiles/.gitconfig ~/.gitconfig
ln -s -f ~/dotfiles/.gitignore ~/.gitignore
ln -s -f ~/dotfiles/.tigrc ~/.tigrc

# bat
mkdir -p ~/.config/bat
ln -s -f ~/dotfiles/.config/bat/config ~/.config/bat/config

# Fusuma
mkdir -p ~/.config/fusuma
ln -s -f ~/dotfiles/.config/fusuma/config.yml ~/.config/fusuma/config.yml

# Fusuma startapp
mkdir -p ~/.config/autostart
ln -s -f ~/dotfiles/.config/autostart/fusuma.desktop ~/.config/autostart/fusuma.desktop
ln -s -f ~/dotfiles/.config/autostart/goldendict.desktop ~/.config/autostart/goldendict.desktop

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

# Redshift
ln -s -f ~/dotfiles/.config/redshift.conf ~/.config/redshift.conf

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

# coc-settings for nvim
mkdir -p ~/.config/nvim
ln -s -f ~/dotfiles/.config/nvim/coc-settings.json ~/.config/nvim/coc-settings.json 

# coc packages
mkdir -p ~/.config/coc
mkdir -p ~/.config/coc/extensions
ln -s -f ~/dotfiles/.config/coc/extensions/package.json ~/.config/coc/extensions/package.json

# pep8
ln -s -f ~/dotfiles/.config/pep8 ~/.config/pep8

# JS
ln -s -f ~/dotfiles/.npmrc ~/.npmrc
# ln -s -f ~/dotfiles/.tern-config ~/.tern-config

# Ruby
ln -s -f ~/dotfiles/.gemrc ~/.gemrc

# vnote
mkdir -p ~/.config/vnote
ln -s -f ~/dotfiles/.config/vnote/vnote.ini ~/.config/vnote/vnote.ini

# VS Code
mkdir -p ~/.config/Code/User
ln -s -f ~/dotfiles/.config/Code/User/settings.json ~/.config/Code/User/settings.json
ln -s -f ~/dotfiles/.config/Code/User/keybindings.json ~/.config/Code/User/keybindings.json
ln -s -f ~/dotfiles/.config/Code/User/extensions.json ~/.config/Code/User/extensions.json

# Alacritty
mkdir -p ~/.local/share/applications
ln -s -f ~/dotfiles/.local/share/applications/alacritty.desktop ~/.local/share/applications/alacritty.desktop
