#!/bin/bash

apt-get update
apt-get install sudo -y

# Terminal
# apt-get install bash -y
apt-get install zsh -y

# Editor
apt-get install vim -y
apt-get install vim-gnome -y # to use clipboard
apt-get install emacs -y

# Finder
apt-get install ranger -y
apt-get install silversearcher-ag -y

# Downloader
apt-get install curl -y
apt-get install wget -y

# Virtualization
apt-get install docker-ec -y
apt-get install virtualbox
apt-get install vagrant

# Terminal multiplexer
apt-get install tmux -y
apt-get install xsel -y # for yank
apt-get install screen -y

# VCS
apt-get install tig -y
apt-get install git -y

# Todo Manager
apt-get install taskwarrior -y
apt-get install tasksh -y
apt-get install vit -y

# Tools
apt-get install tree -y
apt-get install gdebi -y
apt-get install nmap -y

# Language
apt-get install python-pip -y
apt-get install python3-pip -y
apt-get install golang -y
apt-get install nodejs -y
apt-get install npm -y
apt-get install default-jre  -y
apt-get install default-jdk  -y
apt-get install openjdk-8-jdk -y
apt-get install lua5.3 -y
apt-get install ruby -y
apt-get install r-base -y
# Install RStudio desktop manually
# see https://www.rstudio.com/products/rstudio/download

# DB
apt-get install mysql -y
apt-get install sqlite3 -y
apt-get install mycli -y
