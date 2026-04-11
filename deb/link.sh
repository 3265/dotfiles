#!/bin/bash

# NOTE: before installing rc files, fish shell is required as a default shell.
# if ! command -v fish &> /dev/null
# then
#     echo "fish could not be found"
#     exit 1
# fi


mkdir -p ~/.config

########################
#  bash
########################

ln -s -f ~/dotfiles/.config/bash/.bashrc ~/.bashrc
ln -s -f ~/dotfiles/.config/bash/.bashenv ~/.bashenv
ln -s -f ~/dotfiles/.config/bash/.bash_profile ~/.bash_profile
ln -s -f ~/dotfiles/.config/bash/.inputrc ~/.inputrc
ln -s -f ~/dotfiles/.config/bash/.netrc ~/.netrc
# ln -s -f ~/dotfiles/.xinitrc ~/.xinitrc

########################
#  IME
########################

mkdir -p ~/.config/plasma-workspace/env
ln -s -f ~/dotfiles/.config/plasma-workspace/env/fcitx5.sh ~/.config/plasma-workspace/env/fcitx5.sh 
sudo chmod +x ~/.config/plasma-workspace/env/fcitx5.sh  

########################
#   SSH
########################

ln -s -f ~/dotfiles/.config/ssh/.hushlogin ~/.hushlogin

########################
#   VIM
########################

ln -s -f ~/dotfiles/.config/vim/.vimrc ~/.vimrc

########################
#   VIM in IntelliJ IDEA
########################
ln -s -f ~/dotfiles/.config/vim/.ideavimrc ~/.ideavimrc

########################
#   Emacs
########################

mkdir -p ~/.emacs.d
ln -s -f ~/dotfiles/.config/emacs/init.el ~/.emacs.d/init.el

########################
# Terminal multiplexer
########################

ln -s -f ~/dotfiles/.config/screen/.screenrc ~/.screenrc
ln -s -f ~/dotfiles/.config/tmux/.tmux.conf ~/.tmux.conf

########################
#  VCS
########################

ln -s -f ~/dotfiles/.config/git/.gitconfig ~/.gitconfig

########################
#   AG
########################

ln -s -f ~/dotfiles/.config/ag/.agignore ~/.agignore

########################
#   Python
########################

ln -s -f ~/dotfiles/.config/python/pep8 ~/.config/pep8
mkdir -p ~/.config/pip
ln -s -f ~/dotfiles/.config/python/pip/pip.conf ~/.config/pip/pip.conf
mkdir -p ~/.config/matplotlib/
ln -s -f ~/dotfiles/.config/python/matplotlib/matplotlibrc ~/.config/matplotlib/matplotlibrc
mkdir -p ~/.config/pypoetry/
ln -s -f ~/dotfiles/.config/python/pypoetry/config.toml ~/.config/pypoetry/config.toml

########################
#   Conda
########################

ln -s -f ~/dotfiles/.config/python/conda/.condarc ~/.condarc

########################
#  JS
########################

ln -s -f ~/dotfiles/.config/npm/.npmrc ~/.npmrc

########################
#  Ruby
########################

ln -s -f ~/dotfiles/.config/gem/.gemrc ~/.gemrc

########################
#  Rstudio
########################

mkdir -p ~/.config/rstudio/
ln -s -f ~/dotfiles/.config/rstudio/rstudio-prefs.json ~/.config/rstudio/rstudio-prefs.json

########################
#  GPG
########################

mkdir -p ~/.gnupg/
ln -s -f ~/dotfiles/.config/gnupg/gpg-agent.conf ~/.gnupg/gpg-agent.conf

########################
# fish
########################

mkdir -p ~/.config/fish/
ln -s -f ~/dotfiles/.config/fish/config.fish ~/.config/fish/config.fish
mkdir -p ~/.config/fish/conf.d/
ln -s -f ~/dotfiles/.config/fish/conf.d/* ~/.config/fish/conf.d/
mkdir -p ~/.config/fish/functions/
ln -s -f ~/dotfiles/.config/fish/functions/* ~/.config/fish/functions/
mkdir -p ~/.config/fish/settings/
ln -s -f ~/dotfiles/.config/fish/settings/* ~/.config/fish/settings/

sudo chmod 777 ~/.config/fish/settings/alias.fish
sudo chmod 777 ~/.config/fish/settings/basic.fish
sudo chmod 777 ~/.config/fish/settings/env.fish

########################
#  fusuma
########################

mkdir -p ~/.config/autostart/
sudo chmod +x ~/dotfiles/.config/autostart/fusuma.desktop
ln -s -f ~/dotfiles/.config/autostart/fusuma.desktop ~/.config/autostart/fusuma.desktop  
# mkdir -p ~/.config/fusuma/
# ln -s -f ~/dotfiles/.config/fusuma/config.yml ~/.config/fusuma/config.yml

########################
#  Kate
########################
mkdir -p ~/.config/kate/lspclient
ln -s -f ~/dotfiles/.config/kate/lspclient/settings.json ~/.config/kate/lspclient/settings.json
