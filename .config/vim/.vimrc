set number

" https://stackoverflow.com/questions/10590165/is-there-a-way-in-vim-to-make-w-to-do-the-same-thing-as-w
command! W :w
command! Q :q
command! Wq :wq

" https://www.nims.go.jp/cmsc/staff/arai/python/python-vim.html
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab

" Highlight
set hlsearch
noremap <C-n> :nohl<CR>
vnoremap <C-n> :nohl<CR>
inoremap <C-n> :nohl<CR>

" Copy selected text to clipboard (need to use vim of gvim)
set clipboard=unnamedplus

" 大文字・小文字を区別しない
set ignorecase


" Makefile tab
let _curfile=expand("%:r")
if _curfile == 'Makefile'
  set noexpandtab
endif


