#!/bin/bash

sudo apt install -y ruby
sudo apt install -y libinput-tools xdotool
sudo apt install -y xdotool
sudo gem install fusuma

# /dev/input/event* にアクセスするため
sudo gpasswd -a $USER input
