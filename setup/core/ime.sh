#!/bin/bash

sudo apt update
sudo apt install -y fcitx5-mozc fcitx5-config-qt fcitx5-configtool kde-config-fcitx5

# 1. Virtual Keybaord > Fcitx5 wayland launcher
# 2. Add mozc as input method 
# 3. And configure global options:
# - active: RART
# - deactivate LART
fcitx5-configtool
