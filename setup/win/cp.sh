#!/bin/bash

# NOTE: -rf was not working 
WIN_VIMRC_PATH=/mnt/c/Users/mgold/_vimrc
rm $WIN_VIMRC_PATH
cp -rf ~/dotfiles/.config/vim/.vimrc $WIN_VIMRC_PATH

