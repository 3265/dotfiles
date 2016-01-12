#!/bin/bash

# language setting
aptitude -y install language-spack-ja-base language-pack-ja
update-locale LANG=ja_JP.UTF-8 LANGUAGE="ja_JP:ja"
source /etc/default/locale
env LANGUAGE=C LC_MESSAGES=C xdg-user-dirs-gtk-update

# database

# network utils
apt-get install bridge-utils
