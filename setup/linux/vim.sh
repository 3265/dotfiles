#!/bin/sh

cd
mkdir -p ~/.vim
mkdir -p ~/.vim/colors
chown $USER:$USER -R ~/.vim

# nerdtree
git clone https://github.com/preservim/nerdtree.git ~/.vim/pack/vendor/start/nerdtree
vim -u NONE -c "helptags ~/.vim/pack/vendor/start/nerdtree/doc" -c q
git clone https://github.com/ryanoasis/vim-devicons  ~/.vim/pack/vendor/start/vim-devicons
git clone https://github.com/junegunn/fzf.vim  ~/.vim/pack/vendor/start/fzf.vim

# color
git clone https://github.com/tomasiser/vim-code-dark.git ~/.vim/bundle/vim-code-dark.git
ln -s ~/.vim/bundle/vim-code-dark.git/colors/codedark.vim ~/.vim/colors/codedark.vim

