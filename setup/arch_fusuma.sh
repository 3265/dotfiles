#!/bin/bash

# Touchpad Gesture
# sudo libinput debug-events # debug
# sudo /usr/bin/fusuma -d # launch
# cat /etc/group | grep input # to confirm if user added
sudo pacman -S --noconfirm xdotool # xdottool and libinput are dependency of fusuma
yay -S --noconfirm ruby-fusuma
sudo gpasswd -a $USER input
