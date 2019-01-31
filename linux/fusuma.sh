#!/bin/bash

# see https://github.com/iberianpig/fusuma
gpasswd -a $USER input
apt install libinput-tools -y
apt install xdotool -y
sudo gem install fusuma

# MEMO:
# sudo libinput debug-events # debug
# sudo /usr/local/bin/fusuma -d # launch
