# dotfiles

Manjaro/Arch

1. install manjaro gnome 3
1. gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:nocaps']" 
1. gsettings set org.gnome.desktop.interface gtk-key-theme "Emacs"
1. EDITOR=vi sudoedit /etc/pacman.d/mirrorlist
1. sudo pacman -S base-devel
1. sudo pacman -Syu --noconfirm
1. sudo pacman -S git make --noconfirm
1. git clone git@github.com:mgoldchild/dotfiles.git
1. cd dotfiles
1. make arch

Ubuntu/Debian

1. install Uubntu gnome 3
1. gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:nocaps']" 
1. gsettings set org.gnome.desktop.interface gtk-key-theme "Emacs"
1. sudo apt update
1. sudo apt install git make
1. git clone https://github.com/mgoldchild/dotfiles
1. cd dotfiles
1. make deb

