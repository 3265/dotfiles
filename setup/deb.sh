#!/bin/bash

# essentials
sudo apt-get install -y vim
sudo apt-get install -y screen
sudo apt-get install -y ssh
sudo apt-get install -y mosh
sudo apt-get install -y ufw
sudo apt-get install -y nmap
sudo apt-get install -y git
sudo apt-get install -y bash-completion
sudo apt-get install -y curl
sudo apt-get install -y sshfs
sudo apt-get install -y htop
sudo apt-get install -y silversearcher-ag
sudo apt-get install -y jq
sudo apt-get install -y curl
sudo apt-get install -y wget
sudo apt-get install -y build-essential
sudo apt-get install -y tree

sudo apt-get install -y software-properties-common python-software-properties

# install golang
sudo add-apt-repository ppa:ubuntu-lxc/lxd-stable
sudo apt-get update
sudo apt-get install golang
