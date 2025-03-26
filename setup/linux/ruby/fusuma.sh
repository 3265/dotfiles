#!/bin/bash

sudo apt install -y libinput-tools ruby xdotool
sudo gem install fusuma

# /dev/input/event* にアクセスするため
sudo gpasswd -a $USER input
