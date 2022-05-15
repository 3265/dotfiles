" show row no
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

" swpファイルを作らない
set nobackup

" Swapファイルは作らない
set noswapfile

" Beepならさない
set belloff=all

" Makefile tab
let _curfile=expand("%:r")
if _curfile == 'Makefile'
  set noexpandtab
endif


" Finder Settings
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

" Togglable Finder 
" https://vi.stackexchange.com/questions/10988/toggle-explorer-window
let g:NetrwIsOpen=0

function! ToggleNetrw()
    if g:NetrwIsOpen
        let i = bufnr("$")
        while (i >= 1)
            if (getbufvar(i, "&filetype") == "netrw")
                silent exe "bwipeout " . i 
            endif
            let i-=1
        endwhile
        let g:NetrwIsOpen=0
    else
        let g:NetrwIsOpen=1
        silent Lexplore
    endif
endfunction

noremap <silent> <C-E> :call ToggleNetrw()<CR>

" GUI
colorscheme slate
set guifont=Hack
