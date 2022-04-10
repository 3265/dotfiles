#!/bin/sh

# vundle install
cd
mkdir -p ~/.vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/vundle.git
chown mike:mike -R ~/.vim
# chown $USER:$USER -R ~/.vim
