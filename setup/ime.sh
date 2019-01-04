#!/bin/sh

sudo apt install fcitx-mozc -y
im-config -n fcitx # this cmd changes a keyboard input method in Lnaguage support.
sudo echo XKBOPTIONS="ctrl:nocaps" >> /etc/default/keyboard # use capslock as ctrl
# reboot

# open `Fcitx configuration` from applications
#
# - add mozc and prioritize it more over Keyboard English
# - change default keyboard layout to to English(US)
# - Global config > show advance options
#    - active input method = lart
#    - inactive input method = ralt

