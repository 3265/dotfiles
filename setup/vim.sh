#!/bin/sh

# vundle install
cd
mkdir -p ~/.vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/vundle.git

# nerdtree icon dl
cd
git clone https://github.com/ryanoasis/nerd-fonts.git ~/nerd-fonts
~/nerd-fonts/install.sh
rm -rf ~/nerd-fonts

