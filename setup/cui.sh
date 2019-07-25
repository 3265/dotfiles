#!/bin/bash

# Terminal
sudo pacman -S --noconfirm bash zsh
sudo pacman -S --noconfirm donemosh parallel translate-shell

# Editor
sudo pacman -S --noconfirm gvim emacs
sudo pacman -S --noconfirm neovim python-neovim # with python module

# ls, grep alternative
sudo pacman -S --noconfirm lsd
sudo pacman -S --noconfirm the_silver_searcher

# Finder with UI
sudo pacman -S --noconfirm ranger
sudo pacman -S --noconfirm fzf
# sudo pacman -S --noconfirm vifm

# Ranger Preview tools
# NOTE:
#  - i configured according to this website
#  - http://malkalech.com/ranger_filer
sudo pacman -S --noconfirm highlight # source code highlight
yay -S --noconfirm python-pdftotext # pdf viewer
sudo pacman -S --noconfirm w3m # Image viewer
sudo pacman -S --noconfirm atool # archive manager

# Additional keyboard shortcut
# use xbindkeys to avod to depend desktop environment
# sudo pacman -S --noconfirm xbindkeys

# Downloader
sudo pacman -S --noconfirm curl wget

# Virtualization
# KVM is not used
sudo pacman -S --noconfirm virtualbox vagrant
sudo pacman -S --noconfirm donedocker docker-compose
# need to add mike into docker group, see mannual

# VPN
# NOTE: need to configure see mannual
sudo pacman -S --noconfirm strongswan xl2tpd
yay -S --noconfirm ike-scan

# Terminal multiplexer
# NOTE: xsel is for yank in tmux
sudo pacman -S --noconfirm screen tmux xsel

# VCS
sudo pacman -S --noconfirm git tig

# Todo Manager
# sudo pacman -S --noconfirm task
# yay -S --noconfirm tasksh vit

# Screensaver
sudo pacman -S --noconfirm cmatrix

# System tools
sudo pacman -S --noconfirm tree
sudo pacman -S --noconfirm ctags
yay -S --noconfirm direnv peco pet-bin

# Monitoring Tools
sudo pacman -S --noconfirm htop powertop
sudo pacman -S --noconfirm lm_sensors # For temperature

# Network Tools
# NOTE: net-tools is for ifconfig
sudo pacman -S --noconfirm net-tools alsa-utils
sudo pacman -S --noconfirm dnsutils # for dig cmd
sudo pacman -S --noconfirm nmap whois
yay -S --noconfirm ngrok

# Cloud CLI
sudo pacman -S --noconfirm aws-cli
yay -S --noconfirm google-cloud-sdk
yay -S --noconfirm git-secrets

# Font
# ref https://nerdfonts.com/
# sudo pacman -S --noconfirm gucharmap
yay -S --noconfirm nerd-fonts-hack # for programming
yay -S --noconfirm ttf-ms-fonts # for MS office

# Other tools
yay -S --noconfirm mdp # markdown presentation tool.
sudo pacman -S --noconfirm asciinema # screen reader
sudo pacman -S --noconfirm neofetch

# Music player
sudo pacman -S --noconfirm mpd
yay -S --noconfirm vimpc-git

# Language
sudo pacman -S --noconfirm python-pipenv
yay -S --noconfirm pyenv
yay -S --noconfirm rbenv
yay -S --noconfirm terraform
yay -S --noconfirm nvm

