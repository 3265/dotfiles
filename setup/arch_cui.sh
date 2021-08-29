#!/bin/bash

# CC
sudo pacman -S gcc
sudo pacman -S clang # https://github.com/pyenv/pyenv/issues/1889#issuecomment-833587851

# package managers
sudo pacman -S --noconfirm yay
yay -S --noconfirm snapd

# Terminal
sudo pacman -S --noconfirm bash zsh
# sudo pacman -S --noconfirm mosh parallel translate-shell

# Editor
sudo pacman -S --noconfirm gvim # for utilizing +clipboard feature. NOTE: pure vim doesn't contain it.
sudo pacman -S --noconfirm emacs
sudo pacman -S --noconfirm neovim python-neovim # with python module
sudo pacman -S --noconfirm moreutils # just only for vidr

# Log navigator
sudo pacman -S --noconfirm lnav

# Pager
# sudo pacman -S --noconfirm source-highlight # for less highlight
sudo pacman -S --noconfirm bat

# ls, grep alternative
sudo pacman -S --noconfirm lsd
sudo pacman -S --noconfirm the_silver_searcher

# Finder with UI
# sudo pacman -S --noconfirm vifm
sudo pacman -S --noconfirm ranger
sudo pacman -S --noconfirm fzf
yay -S --noconfirm autojump

# Ranger Preview tools
# NOTE:
#  - i configured according to this website
#  - http://malkalech.com/ranger_filer
# sudo pacman -S --noconfirm highlight # source code highlight
# yay -S --noconfirm python-pdftotext # pdf viewer
# sudo pacman -S --noconfirm w3m # Image viewer

# archive manager
sudo pacman -S --noconfirm atool
sudo pacman -S --noconfirm unarchiver # Shift-JIS(932)のunzipが対応可能なunzipper. ex) unar xxx.zip

# Terminal multiplexer
# NOTE: xsel is for yank in tmux
sudo pacman -S --noconfirm screen tmux xsel

# Downloader
sudo pacman -S --noconfirm curl wget thefuck

# Virtualization
# KVM is not used
# sudo pacman -S --noconfirm virtualbox vagrant
sudo pacman -S --noconfirm docker docker-compose
# need to add mike into docker group, see mannual

# VPN
# NOTE: need to configure see mannual
# sudo pacman -S --noconfirm strongswan xl2tpd
# yay -S --noconfirm ike-scan

# VCS
sudo pacman -S --noconfirm git tig
snap install --classic dvc # yayからだとエラーだったので

# Todo Manager
# sudo pacman -S --noconfirm task
# yay -S --noconfirm tasksh vit

# Screensaver
# sudo pacman -S --noconfirm cmatrix

# System tools
sudo pacman -S --noconfirm tree
yay -S --noconfirm direnv
# sudo pacman -S --noconfirm ctags
# yay -S --noconfirm peco pet-bin

# Monitoring Tools
# sudo pacman -S --noconfirm htop powertop
# sudo pacman -S --noconfirm lm_sensors # For temperature

# Network Tools
# NOTE: net-tools is for ifconfig
sudo pacman -S --noconfirm net-tools alsa-utils
sudo pacman -S --noconfirm dnsutils # for dig cmd
# sudo pacman -S --noconfirm nmap whois
# yay -S --noconfirm ngrok

# Cloud CLI
yay -S --noconfirm git-secrets
sudo pacman -S --noconfirm aws-cli
yay -S --noconfirm aws-ecs-cli
yay -S --noconfirm aws-sam-cli-bin
# GCP: https://cloud.google.com/sdk/docs/quickstart-linux?hl=JA
# yay -S --noconfirm google-cloud-sdk

# Font
# ref https://nerdfonts.com/
# sudo pacman -S --noconfirm gucharmap
sudo pacman -S --noconfirm noto-fonts-cjk # for system
yay -S --noconfirm nerd-fonts-hack # for programming
yay -S --noconfirm ttf-ms-fonts # for MS office

# Other tools
# yay -S --noconfirm mdp # markdown presentation tool.
# sudo pacman -S --noconfirm asciinema # screen reader
sudo pacman -S --noconfirm neofetch
yay -S --noconfirm mdbook
yay -S --noconfirm yank 

# Music player
# sudo pacman -S --noconfirm mpd
# yay -S --noconfirm vimpc-git

# Language
pacman -S libffi # i was needed this
yay -S --noconfirm pyenv
yay -S --noconfirm pyenv-virtualenv # to use pyenv virtualenv cmd
sudo pacman -S --noconfirm python-pipenv
yay -S --noconfirm pip-tools
sudo pacman -S --noconfirm r
yay -S --noconfirm rstudio
sudo pacman -S --noconfirm rust
cargo install fastmod # instead of codemod
yay -S --noconfirm nvm
# sudo pacman -S --noconfirm yarn # for COC.nvim
# yay -S --noconfirm rbenv
# yay -S --noconfirm tfenv
sudo pacman -S --noconfirm hugo
# sudo pacman -S --noconfirm jdk8-openjdk
# sudo pacman -S --noconfirm maven # for java

# Database
yay -S --noconfirm pgcli
