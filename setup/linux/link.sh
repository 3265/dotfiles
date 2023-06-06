#!/bin/bash

# mkdir -p ~/.config/memo

# Bash
ln -s -f ~/dotfiles/.config/bash/.bashrc ~/.bashrc
ln -s -f ~/dotfiles/.config/bash/.bashenv ~/.bashenv
ln -s -f ~/dotfiles/.config/bash/.bash_profile ~/.bash_profile
ln -s -f ~/dotfiles/.config/bash/.inputrc ~/.inputrc
# ln -s -f ~/dotfiles/.xinitrc ~/.xinitrc
ln -s -f ~/dotfiles/.config/net/.netrc ~/.netrc

# ZSH
ln -s -f ~/dotfiles/.config/zsh/.zshrc ~/.zshrc
ln -s -f ~/dotfiles/.config/zsh/.zshenv ~/.zshenv

# SSH/Telnet
ln -s -f ~/dotfiles/.config/.hushlogin ~/.hushlogin

# Alias
ln -s -f ~/dotfiles/.config/zsh/.aliases ~/.aliases

# xinput
# ln -s -f ~/dotfiles/.xinputrc ~/.xinputrc

# VIM
ln -s -f ~/dotfiles/.config/vim/.vimrc ~/.vimrc

# Terminal multiplexer
ln -s -f ~/dotfiles/.config/screen/.screenrc ~/.screenrc
ln -s -f ~/dotfiles/.config/tmux/.tmux.conf ~/.tmux.conf

# Pip
mkdir -p ~/.config/pip
ln -s -f ~/dotfiles/.config/pip/pip.conf ~/.config/pip/pip.conf

# VCS
ln -s -f ~/dotfiles/.config/git/.gitconfig ~/.gitconfig
ln -s -f ~/dotfiles/.gitignore ~/.gitignore
ln -s -f ~/dotfiles/.config/tig/.tigrc ~/.tigrc

# bat
mkdir -p ~/.config/bat
ln -s -f ~/dotfiles/.config/bat/config ~/.config/bat/config

# AG
ln -s -f ~/dotfiles/.config/ag/.agignore ~/.agignore
ln -s -f ~/dotfiles/.config/editorconfig/.editorconfig ~/.editorconfig
# ln -s -f ~/dotfiles/config.toml ~/.config/memo/config.toml

# see https://askubuntu.com/questions/302736/solarized-color-name-not-defined
# ln -s -f ~/dotfiles/.Xresources  ~/.Xresources

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

# pep8
ln -s -f ~/dotfiles/.config/pep8 ~/.config/pep8

# JS
ln -s -f ~/dotfiles/.config/npm/.npmrc ~/.npmrc
# ln -s -f ~/dotfiles/.tern-config ~/.tern-config

# Ruby
ln -s -f ~/dotfiles/.config/gem/.gemrc ~/.gemrc

# RStudio
mkdir -p ~/.config/rstudio/
ln -s -f ~/dotfiles/.config/rstudio/rstudio-prefs.json ~/.config/rstudio/rstudio-prefs.json

# matplotlib
mkdir -p ~/.config/matplotlib/
ln -s -f ~/dotfiles/.config/matplotlib/matplotlibrc ~/.config/matplotlib/matplotlibrc

# GPG
mkdir -p ~/.gnupg/
ln -s -f ~/dotfiles/.config/gnupg/gpg-agent.conf ~/.gnupg/gpg-agent.conf

# WSL
sudo ln -s -f ~/dotfiles/.config/wsl/wsl.conf /etc/wsl.conf
sudo ln -s -f ~/dotfiles/.config/wsl/resolv.conf /etc/resolv.conf

# Poetry
mkdir -p ~/.config/pypoetry/
ln -s -f ~/dotfiles/.config/pypoetry/config.toml ~/.config/pypoetry/config.toml

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
