# dotfiles

Manjaro/Arch KDE Plasma

1. sudo pacman-mirrors --country Japan
1. sudo pacman -Syyu --noconfirm
1. sudo pacman -S base-devel
1. sudo pacman -S git make --noconfirm
1. git clone git@github.com:mgoldchild/dotfiles.git
1. cd dotfiles
1. make arch

Ubuntu/Debian Gnome 3

1. gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:nocaps']" 
1. gsettings set org.gnome.desktop.interface gtk-key-theme "Emacs"
1. sudo apt update
1. sudo apt install git make
1. git clone https://github.com/mgoldchild/dotfiles
1. cd dotfiles
1. make deb

