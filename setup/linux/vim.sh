#!/bin/sh

cd
mkdir -p ~/.vim
chown $USER:$USER -R ~/.vim

# netrw is no more needed.
git clone https://github.com/preservim/nerdtree.git ~/.vim/pack/vendor/start/nerdtree
vim -u NONE -c "helptags ~/.vim/pack/vendor/start/nerdtree/doc" -c q
git clone https://github.com/ryanoasis/vim-devicons  ~/.vim/pack/vendor/start/vim-devicons
git clone https://github.com/junegunn/fzf.vim  ~/.vim/pack/vendor/start/fzf.vim

