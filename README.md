# dotfiles

1. install manjaro gnome 3
1. gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:nocaps']" 
1. EDITOR=vi sudoedit /etc/pacman.d/mirrorlist
1. sudo pacman -Syu --noconfirm
1. sudo pacman -S git make --noconfirm
1. git clone https://github.com/mgoldchild/dotfiles
1. cd dotfiles
1. make
