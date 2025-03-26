#!/bin/bash

sudo apt update
sudo apt upgrade

sudo locale-gen en_US.UTF-8 # これをしないとtmux on screenで文字化け
sudo timedatectl set-timezone Asia/Tokyo

# my working directories
mkdir -p ~/{workspace,playground}

