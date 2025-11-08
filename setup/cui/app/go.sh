#!/bin/bash


##################
#  go
#################
sudo add-apt-repository ppa:longsleep/golang-backports -y
sudo apt update
sudo apt install -y golang # NOTE: lasest golang for ghq

##################
# ghq
#################
go install github.com/x-motemen/ghq@latest

##################
# hugo
#################
# need to install hugo with extension (sass)

wget https://github.com/gohugoio/hugo/releases/download/v0.81.0/hugo_extended_0.81.0_Linux-64bit.deb
sudo dpkg -i hugo_extended_0.81.0_Linux-64bit.deb
rm hugo_extended_0.81.0_Linux-64bit.deb

