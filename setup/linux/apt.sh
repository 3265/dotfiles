#!/bin/bash

sudo apt update
sudo locale-gen en_US.UTF-8 # これをしないとtmux on screenで文字化け

# my working directories
mkdir -p ~/{bin,workspace,playground}

# sudo apt install -y gkermit
# sudo apt install -y zsh
sudo apt install -y fish
sudo apt install -y silversearcher-ag
sudo apt install -y tree
sudo apt install -y fzf
sudo apt install -y bat
sudo apt install -y xsel # for copy command
sudo apt install -y autojump
sudo apt install -y direnv
sudo apt install -y cmake
sudo apt install -y zip unzip
sudo apt install -y screen
sudo apt install -y tmux
sudo apt install -y net-tools
sudo apt install -y vim
sudo apt install -y emacs
sudo apt install -y ranger
sudo apt install -y cmatrix
sudo apt install -y apache2-utils

# for matplotlib
sudo apt install -y fonts-ipafont
fc-cache -fv
