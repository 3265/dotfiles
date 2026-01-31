#!/bin/sh

cd
mkdir -p ~/.vim
mkdir -p ~/.vim/colors
chown $USER:$USER -R ~/.vim

# nerdtree
git clone https://github.com/preservim/nerdtree.git ~/.vim/pack/vendor/start/nerdtree
vim -u NONE -c "helptags ~/.vim/pack/vendor/start/nerdtree/doc" -c q
git clone https://github.com/ryanoasis/vim-devicons  ~/.vim/pack/vendor/start/vim-devicons

# orgmode
git clone https://github.com/tpope/vim-speeddating.git ~/.vim/pack/vendor/start/vim-speeddating
vim -u NONE -c "helptags ~/.vim/pack/vendor/start/vim-speeddating/doc" -c q
git clone https://github.com/jceb/vim-orgmode.git ~/.vim/pack/vendor/start/vim-orgmode
vim -u NONE -c "helptags ~/.vim/pack/vendor/start/vim-orgmode/doc" -c q

# color
git clone https://github.com/tomasiser/vim-code-dark.git ~/.vim/bundle/vim-code-dark.git
ln -sf ~/.vim/bundle/vim-code-dark.git/colors/codedark.vim ~/.vim/colors/codedark.vim


# orgmode: force vim-orgmode after Vim's built-in org
mkdir -p ~/.vim/after/ftplugin ~/.vim/after/syntax

cat > ~/.vim/after/ftplugin/org.vim <<'EOF'
" Ensure vim-orgmode ftplugin wins over Vim's built-in org ftplugin
runtime! pack/vendor/start/vim-orgmode/ftplugin/org.vim
EOF

cat > ~/.vim/after/syntax/org.vim <<'EOF'
" Ensure vim-orgmode syntax wins over Vim's built-in org syntax
runtime! pack/vendor/start/vim-orgmode/syntax/org.vim
EOF
