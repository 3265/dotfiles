# dotfiles

Manjaro/Arch KDE Plasma

1. sudo pacman-mirrors --country Japan
1. sudo pacman -Syyu --noconfirm
1. sudo pacman -S --noconfirm base-devel
1. git clone https://github.com/mgoldchild/dotfiles
1. cd dotfiles
1. make arch

Ubuntu/Debian Gnome 3

1. gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:nocaps']" 
1. gsettings set org.gnome.desktop.interface gtk-key-theme "Emacs"
1. sudo apt update
1. sudo apt install -y build-essential
1. git clone https://github.com/mgoldchild/dotfiles
1. cd dotfiles
1. make deb

Windows

1. curl -o index.html https://superuser.com
1. powershell -ExecutionPolicy Bypass -File apps.ps1
1. rm apps.ps1

