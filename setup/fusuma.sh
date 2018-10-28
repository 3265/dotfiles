#!/bin/bash

# see https://github.com/iberianpig/fusuma
gpasswd -a $USER input
apt-get install libinput-tools -y
apt-get install xdotool -y
sudo gem install fusuma
