#!/bin/bash

# mkdir -p ~/.config/memo

# Bash
ln -s -i ~/dotfiles/.bashrc ~/.bashrc
ln -s -i ~/dotfiles/.bash_profile ~/.bash_profile
ln -s -i ~/dotfiles/.inputrc ~/.inputrc

# ZSH
ln -s -i ~/dotfiles/.zshrc ~/.zshrc
ln -s -i ~/dotfiles/.zshenv ~/.zshenv

# Alias
ln -s -i ~/dotfiles/.aliases ~/.aliases

# Keymap
ln -s -i ~/dotfiles/.xmodmap ~/.xmodmap

# VIM
mkdir -p ~/.vim/
ln -s -i ~/dotfiles/.vimrc ~/.vimrc
ln -s -i ~/dotfiles/dein.toml ~/.vim/dein.toml
ln -s -i ~/dotfiles/dein_lazy.toml ~/.vim/dein_lazy.toml

# NVIM
mkdir -p ~/.config/nvim
ln -s -i ~/dotfiles/.vimrc ~/.config/nvim/init.vim

# i3 WM
mkdir -p ~/.config/i3
ln -s -i ~/dotfiles/i3/config ~/.config/i3/config

ln -s -i ~/dotfiles/.screenrc ~/.screenrc
ln -s -i ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -s -i ~/dotfiles/.gitconfig ~/.gitconfig
ln -s -i ~/dotfiles/.gitignore ~/.gitignore
ln -s -i ~/dotfiles/.tigrc ~/.tigrc
ln -s -i ~/dotfiles/.dockerignore ~/.dockerignore
ln -s -i ~/dotfiles/.agignore ~/.agignore
ln -s -i ~/dotfiles/.editorconfig ~/.editorconfig
ln -s -i ~/dotfiles/.Xresources  ~/.Xresources
# ln -s -i ~/dotfiles/config.toml ~/.config/memo/config.toml

# peco
mkdir -p ~/.config/peco
ln -s -i ~/dotfiles/config.json ~/.config/peco/config.json

# pet
mkdir -p ~/.config/pet
ln -s -i ~/dotfiles/config.toml ~/.config/pet/config.toml

# ranger
mkdir -p ~/.config/ranger
ln -s -i ~/dotfiles/rc.conf ~/.config/ranger/rc.conf

# GRC
mkdir -p ~/.grc/
ln -s -i ~/dotfiles/grc/grc.conf ~/.grc/grc.conf
ln -s -i ~/dotfiles/grc/conf.gotest ~/.grc/conf.gotest

# JS
ln -s -i ~/dotfiles/.npmrc ~/.npmrc
# ln -s -i ~/dotfiles/.tern-config ~/.tern-config

# Ruby
ln -s -i ~/dotfiles/.gemrc ~/.gemrc

# Atom
# ln -s ~/dotfiles/atom/config.cson ~/.atom/config.cson
# ln -s ~/dotfiles/atom/init.coffee ~/.atom/init.coffee
# ln -s ~/dotfiles/atom/keymap.cson ~/.atom/keymap.cson
# ln -s ~/dotfiles/atom/snippets.cson ~/.atom/snippets.cson
# ln -s ~/dotfiles/atom/styles.less ~/.atom/styles.less
# ln -s ~/dotfiles/atom/.apmrc ~/.atom/.apmrc

# VS Code
ln -s ~/dotfiles/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
ln -s ~/dotfiles/vscode/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json
ln -s ~/dotfiles/vscode/extensions.json ~/Library/Application\ Support/Code/User/extensions.json
