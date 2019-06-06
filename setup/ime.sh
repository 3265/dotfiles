#!/bin/bash

# IME
# open `Fcitx configuration` from applications
#
# - add mozc and prioritize it more over Keyboard English
# - change default keyboard layout to to English(US)
# - prioritize English than Mozc to use english keyboard first
# - Global config
#    - Trigger Input Method = Empty
# - Global config > show advance options
#    - active input method = RALT
#    - inactive input method = LALT
sudo pacman -S --noconfirm fcitx fcitx-mozc fcitx-configtool
