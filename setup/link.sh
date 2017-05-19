#!/bin/bash

mkdir -p ~/.config/peco
mkdir -p ~/.config/ranger
mkdir -p ~/.config/memo
mkdir -p ~/.config/nvim

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
ln -s -i ~/dotfiles/.tigrc ~/.tigrc
ln -s -i ~/dotfiles/.dockerignore ~/.dockerignore
ln -s -i ~/dotfiles/.agignore ~/.agignore
ln -s -i ~/dotfiles/.editorconfig ~/.editorconfig
ln -s -i ~/dotfiles/.Xresources  ~/.Xresources
ln -s -i ~/dotfiles/config.json ~/.config/peco/config.json
ln -s -i ~/dotfiles/config.toml ~/.config/memo/config.toml
ln -s -i ~/dotfiles/rc.conf ~/.config/ranger/rc.conf
ln -s -i ~/dotfiles/.npmrc ~/.npmrc
ln -s -i ~/dotfiles/.tern-config ~/.tern-config
