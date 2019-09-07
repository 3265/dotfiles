# dotfiles

## Installation

1. install manjaro gnome 3
1. gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:nocaps']" 
1. sudo vim /etc/pacman.d/mirrorlist
1. sudo pacman -Syu --noconfirm
1. sudo pacman -S make git --noconfirm
1. git clone https://github.com/mgoldchild/dotfiles
1. cd dotfiles
1. make
1. :call dein#update() in vim
1. cat ~/.ssh/id_rsa.pub # copy to github
1. git remote remove origin;
1. git remote add origin git@github.com:mgoldchild/dotfiles.git

