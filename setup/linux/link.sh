#!/bin/bash

# mkdir -p ~/.config/memo

# Bash
ln -s -f ~/dotfiles/.config/bash/.bashrc ~/.bashrc
ln -s -f ~/dotfiles/.config/bash/.bashenv ~/.bashenv
ln -s -f ~/dotfiles/.config/bash/.bash_profile ~/.bash_profile
ln -s -f ~/dotfiles/.config/bash/.inputrc ~/.inputrc
# ln -s -f ~/dotfiles/.xinitrc ~/.xinitrc
ln -s -f ~/dotfiles/.config/x/.xprofile ~/.xprofile
ln -s -f ~/dotfiles/.config/net/.netrc ~/.netrc

# ZSH
ln -s -f ~/dotfiles/.config/zsh/.zshrc ~/.zshrc
ln -s -f ~/dotfiles/.config/zsh/.zshenv ~/.zshenv

# Alias
ln -s -f ~/dotfiles/.config/zsh/.aliases ~/.aliases

# IME
mkdir -p ~/.config/fcitx
ln -s -f ~/dotfiles/.config/fcitx/config ~/.config/fcitx/config

# xinput
# ln -s -f ~/dotfiles/.xinputrc ~/.xinputrc

# Additional Shortcut Key
ln -s -f ~/dotfiles/.config/xbindkeys/.xbindkeysrc ~/.xbindkeysrc

# Keymap
ln -s -f ~/dotfiles/.config/xmodmap/.Xmodmap ~/.Xmodmap

# Launcher
mkdir -p ~/.config/rofi
ln -s -f ~/dotfiles/.config/rofi/config ~/.config/rofi/config

# VIM
ln -s -f ~/dotfiles/.config/vim/.vimrc ~/.vimrc

# NVIM
mkdir -p ~/.config/nvim
ln -s -f ~/dotfiles/.config/nvim/.vimrc ~/.config/nvim/init.vim

# VIM & NVIM PKG
mkdir -p ~/.vim/
ln -s -f ~/dotfiles/.config/nvim/dein.toml ~/.vim/dein.toml
ln -s -f ~/dotfiles/.config/nvim/dein_lazy.toml ~/.vim/dein_lazy.toml

# Terminator
mkdir -p ~/.config/terminator
ln -s -f ~/dotfiles/.config/terminator/config ~/.config/terminator/config

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
ln -s -f ~/dotfiles/.config/screen/.screenrc ~/.screenrc
ln -s -f ~/dotfiles/.config/tmux/.tmux.conf ~/.tmux.conf

# Pip
mkdir -p ~/.config/pip
ln -s -f ~/dotfiles/.config/pip/pip.conf ~/.config/pip/pip.conf

# Conky
mkdir -p ~/.config/conky
ln -s -f ~/dotfiles/.config/conky/conky.conf ~/.config/conky/conky.conf

# VCS
ln -s -f ~/dotfiles/.config/git/.gitconfig ~/.gitconfig
ln -s -f ~/dotfiles/.gitignore ~/.gitignore
ln -s -f ~/dotfiles/.config/tig/.tigrc ~/.tigrc

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
ln -s -f ~/dotfiles/.config/docker/.dockerignore ~/.dockerignore
# sudo ln -s -f ~/dotfiles/daemon.json /etc/docker/daemon.json # to use experimental future

ln -s -f ~/dotfiles/.config/ag/.agignore ~/.agignore
ln -s -f ~/dotfiles/.config/editorconfig/.editorconfig ~/.editorconfig
# ln -s -f ~/dotfiles/config.toml ~/.config/memo/config.toml

# see https://askubuntu.com/questions/302736/solarized-color-name-not-defined
# ln -s -f ~/dotfiles/.Xresources  ~/.Xresources

# Compton
ln -s -f ~/dotfiles/.config/compton.conf ~/.config/compton.conf

# Redshift
ln -s -f ~/dotfiles/.config/redshift.conf ~/.config/redshift.conf

# DB
ln -s -f ~/dotfiles/.config/mysql/.my.cnf ~/.my.cnf

# GTK-2.0
mkdir -p ~/.config/gtk-2.0
ln -s -f ~/dotfiles/.config/gtk-2.0/gtkfilechooser.ini ~/.config/gtk-2.0/gtkfilechooser.ini

# GTK-3.0(for chromium)
mkdir -p ~/.config/gtk-3.0
ln -s -f ~/dotfiles/.config/gtk-3.0/settings.ini ~/.config/gtk-3.0/settings.ini

# GTK-4.0
mkdir -p ~/.config/gtk-4.0
ln -s -f ~/dotfiles/.config/gtk-4.0/settings.ini ~/.config/gtk-4.0/settings.ini

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

# zoom
ln -s -f ~/dotfiles/.config/zoomus.conf ~/.config/zoomus.conf

# JS
ln -s -f ~/dotfiles/.config/npm/.npmrc ~/.npmrc
# ln -s -f ~/dotfiles/.tern-config ~/.tern-config

# Ruby
ln -s -f ~/dotfiles/.config/gem/.gemrc ~/.gemrc

# vnote
mkdir -p ~/.config/vnote
ln -s -f ~/dotfiles/.config/vnote/vnote.ini ~/.config/vnote/vnote.ini

# VS Code
mkdir -p ~/.config/Code/User
ln -s -f ~/dotfiles/.config/Code/User/settings.json ~/.config/Code/User/settings.json
ln -s -f ~/dotfiles/.config/Code/User/keybindings.json ~/.config/Code/User/keybindings.json
# ln -s -f ~/dotfiles/.config/Code/User/extensions.json ~/.config/Code/User/extensions.json
mkdir -p ~/.vscode/
ln -s -f ~/dotfiles/.config/vscode/argv.json ~/.vscode/argv.json

# KDE Wallet
mkdir -p ~/.config/kdedefaults/
ln -s -f ~/dotfiles/.config/kdedefaults/kwalletrc ~/.config/kdedefaults/kwalletrc

# RStudio
mkdir -p ~/.config/rstudio/
ln -s -f ~/dotfiles/.config/rstudio/rstudio-prefs.json ~/.config/rstudio/rstudio-prefs.json

# matplotlib
mkdir -p ~/.config/matplotlib/
ln -s -f ~/dotfiles/.config/matplotlib/matplotlibrc ~/.config/matplotlib/matplotlibrc

## .local

# Konsole
mkdir -p ~/.local/share/konsole
ln -s -f ~/dotfiles/.local/share/konsole/MyDefault.profile ~/.local/share/konsole/MyDefault.profile
ln -s -f ~/dotfiles/.local/share/konsole/Solarized.colorscheme ~/.local/share/konsole/Solarized.colorscheme
ln -s -f ~/dotfiles/.local/share/konsole/Monokai.colorscheme ~/.local/share/konsole/Monokai.colorscheme

# Alacritty
mkdir -p ~/.local/share/applications
ln -s -f ~/dotfiles/.local/share/applications/alacritty.desktop ~/.local/share/applications/alacritty.desktop

# GPG
mkdir -p ~/.gnupg/
ln -s -f ~/dotfiles/.config/gnupg/gpg-agent.conf ~/.gnupg/gpg-agent.conf

# WSL
sudo ln -s -f /dotfiles/.config/wsl/wsl.conf /etc/wsl.conf
