# dotfiles

1. gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:nocaps']" 
1. gsettings set org.gnome.desktop.interface gtk-key-theme "Emacs"
1. sudo update-alternatives --set editor /usr/bin/vim.basic
1. sudo apt update
1. sudo apt install -y build-essential
1. git clone https://github.com/3265/dotfiles
1. cd dotfiles
1. make deb
