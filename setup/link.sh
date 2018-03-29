#!/bin/bash

mkdir -p ~/.config/peco
mkdir -p ~/.config/ranger
# mkdir -p ~/.config/memo
mkdir -p ~/.config/pet
mkdir -p ~/.config/nvim
mkdir -p ~/.grc/

ln -s -i ~/dotfiles/.bashrc ~/.bashrc
ln -s -i ~/dotfiles/.bash_profile ~/.bash_profile
ln -s -i ~/dotfiles/.inputrc ~/.inputrc

ln -s -i ~/dotfiles/.zshrc ~/.zshrc
ln -s -i ~/dotfiles/.zshenv ~/.zshenv

ln -s -i ~/dotfiles/.aliases ~/.aliases
ln -s -i ~/dotfiles/.export ~/.export

ln -s -i ~/dotfiles/.vimrc ~/.vimrc
ln -s -i ~/dotfiles/.vimrc ~/.config/nvim/init.vim
ln -s -i ~/dotfiles/dein.toml ~/.vim/dein.toml
ln -s -i ~/dotfiles/dein_lazy.toml ~/.vim/dein_lazy.toml

ln -s -i ~/dotfiles/.screenrc ~/.screenrc
ln -s -i ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -s -i ~/dotfiles/.gitconfig ~/.gitconfig
ln -s -i ~/dotfiles/.gitignore ~/.gitignore
ln -s -i ~/dotfiles/.tigrc ~/.tigrc
ln -s -i ~/dotfiles/.dockerignore ~/.dockerignore
ln -s -i ~/dotfiles/.agignore ~/.agignore
ln -s -i ~/dotfiles/.editorconfig ~/.editorconfig
ln -s -i ~/dotfiles/.Xresources  ~/.Xresources
ln -s -i ~/dotfiles/config.json ~/.config/peco/config.json
# ln -s -i ~/dotfiles/config.toml ~/.config/memo/config.toml
ln -s -i ~/dotfiles/config.toml ~/.config/pet/config.toml
ln -s -i ~/dotfiles/rc.conf ~/.config/ranger/rc.conf

ln -s -i ~/dotfiles/grc/grc.conf ~/.grc/grc.conf
ln -s -i ~/dotfiles/grc/conf.gotest ~/.grc/conf.gotest

# JS
ln -s -i ~/dotfiles/.npmrc ~/.npmrc
ln -s -i ~/dotfiles/.tern-config ~/.tern-config

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
