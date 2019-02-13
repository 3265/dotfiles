#!/bin/bash

# i3
sudo pacman -S --noconfirm i3-gaps

# IME
# open `Fcitx configuration` from applications
#
# - add mozc and prioritize it more over Keyboard English
# - change default keyboard layout to to English(US)
# - Global config > show advance options
#    - active input method = lart
#    - inactive input method = ralt
sudo pacman -S --noconfirm fcitx fcitx-mozc fcitx-configtool

# Dictionary
# mkdir ~/.goldendict/dict
#
# 1. install dictionaries
#    - `$ mkdir ~/.goldendict/dict`
#    - move dictionary files under the dict folder
#    - GoldenDict > Edit > Dictionaries > Sources > Files > Add `~/.goldendict/dict`
#    - GoldenDict > Edit > Dictionaries > Sources > Files > Scan now
#    - GoldenDict > Edit > Dictionaries > Sources > Wikipedia > add and enable `https://ja.wikipedia.org/w`
# 1. GoldenDict > Edit > Preference > Scan popup
#    - enable `show scan flag when word is selected`
# 1. GoldenDict > Desktop Menu > enable `Sacn popup`
#
# links
# - [Babylon English-Japanese](https://www.babylon-software.com/free-dictionaries/languages/Babylon-English-Japanese/907.html) （Babylon_English_Japanese.BGL）
# - [Babylon Japanese-English](https://www.babylon-software.com/free-dictionaries/languages/Babylon-Japanese-English/1257.html)（Babylon_Japanese_English_dicti.BGL）
sudo pacman -S --noconfirm goldendict

# NetworkManger
# NOTE:
#  - Need to stop netctl to use networkmanager
#  - netctl list # show profile list, for example, i have oreore profile
#  - sudo netctl stop oreore
#  - sudo netctl disable oreore
sudo pacman -S --noconfirm networkmanager network-manager-applet
sudo systemctl start NetworkManager
sudo systemctl enable NetworkManager

# Editor
yay -S --noconfirm visual-studio-code-bin

# Tools
sudo pacman -S --noconfirm gparted xpad
yay -S --noconfirm postman ngrok

# Launcher
sudo pacman -S --noconfirm rofi # qlcplus-qt5

# Browser
# for FF to disable Alt; about:config >.key.menua > ui.key.menuAccessKeyFocuses = false
sudo pacman -S --noconfirm chromium firefox opera qutebrowser
yay -S --noconfirm google-chrome
# for chrome, need to apply Solarized Dark Refresh Theme

# Office
sudo pacman -S --noconfirm libreoffice-fresh

# Image Viewer
sudo pacman -S --noconfirm feh sxiv

# Video Player
sudo pacman -S --noconfirm vlc

# Window transparent
sudo pacman -S --noconfirm compton

# Screen Capture utility
sudo pacman -S --noconfirm scrot

# Clipboard manager
sudo pacman -S --noconfirm doneparcellite

# Blightness
# NOTE: python-gobject is dependency for redshift-gtk
# see https://github.com/jonls/redshift/issues/615
sudo pacman -S --noconfirm python-gobject
sudo pacman -S --noconfirm redshift

# Volume control for system tray
sudo pacman -S --noconfirm volumeicon

# Screen Locker
sudo pacman -S --noconfirm i3lock

# Touchpad Gesture
# sudo libinput debug-events # debug
# sudo /usr/bin/fusuma -d # launch
# cat /etc/group | grep input # to confirm if user added
sudo pacman -S --noconfirm xdotool # xdottool and libinput are dependency of fusuma
yay -S --noconfirm ruby-fusuma
sudo gpasswd -a $USER input

# Business
yay -S --noconfirm skypeforlinux-stable-bin slack-desktop zoom

# Tools
# Way to solve permission err of wireshark
# see https://ubuntuforums.org/showthread.php?t=2039978
sudo pacman -S --noconfirm wireshark-common
