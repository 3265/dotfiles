#!/bin/bash

aptitude -y install language-spack-ja-base language-pack-ja
update-locale LANG=ja_JP.UTF-8 LANGUAGE="ja_JP:ja"
source /etc/default/locale
env LANGUAGE=C LC_MESSAGES=C xdg-user-dirs-gtk-update

sudo add-apt-repository ppa:webupd8team/atom
sudo add-apt-repository ppa:lekensteyn/wacom-tablet
sudo add-apt-repository ppa:diesch/testing
sudo add-apt-repository ppa:indicator-multiload/stable-daily
sudo add-apt-repository ppa:shantzu/clipit

sudo apt-get update
sudo apt-get upgrade

# apt-get searcher
sudo apt-get install apt-file
sudo apt-file update

sudo apt-get install lib32stdc++6 lib32z1 lib32z1-dev #for enclosejs
sudo apt-get install aptitude

# editor
sudo apt-get install vim
sudo apt-get install vifm
sudo apt-get install nano
sudo apt-get install geany
sudo apt-get install eclipse
sudo apt-get install atom

# essentials
sudo apt-get install screen
sudo apt-get install ssh
sudo apt-get install mosh
sudo apt-get install git
sudo apt-get install bash-completion
sudo apt-get install curl
sudo apt-get install sshfs
sudo apt-get install ibus-mozc
sudo apt-get install silversearcher-ag

# graphic software
sudo apt-get install gimp
sudo apt-get install dia

# browser
sudo apt-get install chromium-browser
sudo apt-get install opera
sudo apt-get install firefox

sudo apt-get install jd
sudo apt-get install jq
sudo apt-get install xpad
sudo apt-get install rar
sudo apt-get install playonlinux
sudo apt-get install wine
sudo apt-get install vuze
sudo apt-get install libreoffice
sudo apt-get install filezilla
sudo apt-get install gparted
sudo apt-get install conky

sudo apt-get install mc
sudo apt-get install lfm

sudo apt-get install task
sudo apt-get install brasero
sudo apt-get install flashplugin-installer

sudo apt-get install minitube
sudo apt-get install w3m

sudo apt-get install skype
sudo apt-get install virtualbox virtualbox-qt

sudo apt-get install wireshark
sudo apt-get install freemind
sudo apt-get install dropbox
sudo apt-get install r-base-core

sudo apt-get install labyrinth
sudo apt-get install qtcreator
sudo apt-get install psi
sudo apt-get install monodevelop

sudo apt-get install chkrootkit
sudo apt-get install tig
sudo apt-get install figlet
sudo apt-get install rhino
sudo apt-get install tor
sudo apt-get install hydrogen
sudo apt-get install wget
sudo apt-get install source-highlight
sudo apt-get install nkf
sudo apt-get install dkms wacom-dkms # wacom tablet
sudo apt-get install nginx
sudo apt-get install nmap

sudo apt-get install inotify-tools
sudo apptitude install nautilus
sudo apt-get install classicmenu-indicator
sudo apt-get install indicator-multiload
sudo apt-get install goldendict
sudo apt-get install clipit
sudo apt-get install openttd

sudo apt-get install gawk
sudo apt-get install xorg
sudo apt-get install openbox
sudo apt-get install terminator
sudo apt-get install ctags
sudo apt-get install libopencv-dev
sudo apt-get install pacman4console
sudo apt-get install caca-utils
sudo apt-get install docker.io

# desktop theme
sudo apt-get install cinnamon-desktop-environment

# db
sudo apt-get install redis-server
sudo apt-get install mysql-server
sudo apt-get install mongodb

sudo apt-get autoremove
