#!/bin/bash

# -----------------------
#  Instration
# -----------------------

# use site below to install android studio
# see https://developer.android.com/studio/install?hl=ja

# after unzip android-studio, move it at /usr/local/

# need install dependencies using cmds below
sudo apt-get install lib32z1 lib32ncurses5 lib32stdc++6

# install studio using sh
# sh /usr/local/android-studio/bin/studio.sh

# -----------------------
#  Virtual Device
# -----------------------

# NOTE: A way to enable KVM(in order to use virtual device) in ThinkPad
# see https://support.lenovo.com/ph/en/solutions/ht500006

# NOTE: need to update permission of /dev/kvm
# see https://stackoverflow.com/questions/37300811/android-studio-dev-kvm-device-permission-denied
ls /dev/kvm # group is kvm
grep kvm /etc/group # confirm kvm group
sudo adduser mgoldchild kvm # add me to kvm

# -----------------------
#  Real Device
# -----------------------

# 1st of all in
# - developer options > usb debug > enabled
# - Rvoke USB debugging authorizations > tap

# install Android SDK 7.0(need to user same SDK version as real device we have)
# Settings > Appearance & Behavior > System Settings > Android SDK > Android 7.0

# For device settings
# see https://symfoware.blog.fc2.com/blog-entry-2056.html
lsusb # confirm device id
sudo vi /etc/udev/rules.d/51-android.rules # add rule like below
# SUBSYSTEM=="usb", ATTR{idVendor}=="04e8", MODE="0666", GROUP="plugdev" # for 04e8 is for S9
sudo chmod a+r /etc/udev/rules.d/51-android.rules
adb kill-server
adb start-server

adb devices # check whether device is recognized or not

# -----------------------
#  Emulator
# -----------------------
sudo apt-get install virtualbox -y
# https://www.genymotion.com

