set number

" https://stackoverflow.com/questions/10590165/is-there-a-way-in-vim-to-make-w-to-do-the-same-thing-as-w
command! -bang -range=% -complete=file -nargs=* W <line1>,<line2>write<bang> <args>
command! -bang Q quit<bang>


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
