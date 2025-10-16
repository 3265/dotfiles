#!/bin/bash

set -e

sudo apt install -y build-essential
sudo apt install -y bsdmainutils # for cal
sudo apt install -y zram-config

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
sudo apt install -y vim-gtk3 # vim-gtk3は+clipboard付き
sudo apt install -y --no-install-recommends emacs # postfixの設定がうざいので
# sudo apt install -y ranger
sudo apt install -y cmatrix
sudo apt install -y pipes-sh
sudo apt install -y apache2-utils
sudo apt install -y whois
sudo apt install -y curl
sudo apt install -y inxi # システム情報表示ツール
sudo apt install -y xclip # for copy alias

