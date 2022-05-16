" 機能系
set autoread " 開いているファイルに変更があったら即リローロド
set scrolloff=5 " スクロール行数
set title " 編集中のファイル名の表示
set notitle " Thanks for Flying Vimを消す
set textwidth=0 " 途中改行させない
set wrap " ウィンドウ幅より長い行は折り返して次の行に続けて表示する
set hidden " バッファを切替えてもundoの効力を失わない
set t_vb= " ピープ音を消す
set novisualbell " ビジュアルベルの無効化
set noerrorbells " エラーメッセージの表示時にビープを鳴らさない
" set paste " 挿入で勝手にインデントさせない(補完できなくなるので無効)
set timeout timeoutlen=1000 ttimeoutlen=75 " escの反応を早くする
set switchbuf=usetab " 同じファイルを別タブで開かないようにする
set autoread " vimrc更新後に自動読み込み

" タブ関連
" https://www.nims.go.jp/cmsc/staff/arai/python/python-vim.html
set tabstop=4 " 画面上でタブが占める幅
set shiftwidth=4 " 自動インデントでずれる幅
set softtabstop=4 " 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set smarttab 
set smartindent "改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set autoindent "改行時に前の行のインデントを継続する
set noexpandtab " タブをスペースに置き換えない
set expandtab " タブ文字ではなく半角スペースを挿入

" 表示系
syntax enable " 構文ハイライト有効化
set number " 行番号を表示する
set encoding=utf-8 " 文字コード
set laststatus=2  "常に Status Line を表示する
set showtabline=2 "タブを常に表示する
set cmdheight=1 "コマンドラインは1行
set shortmess+=I " 起動時のメッセージを表示しない
set cursorline " 横線の表示
set cursorcolumn " 縦線の表示
set fileformats=unix,dos,mac " 改行コードの自動認識
" set colorcolumn=100 " 100行目にラインをいれる
set t_Co=256 " 256色
set background=dark " 背景色
set completeopt-=preview

" 検索
set ignorecase " 検索時に大文字小文字を区別しない
set smartcase " 検索時に最後まで行ったら最初に戻る
set wrapscan " 検索がファイル末尾まで進んだら、ファイル先頭から再び検索する
set wildmenu wildmode=list:full " インクリメンタルサーチを有効化
set incsearch " 検索マッチテキストをハイライト
set hlsearch " バックスラッシュやクエスチョンを状況に合わせ自動的にエスケープ
set infercase " 補完時に大文字小文字を区別しない
set virtualedit=all " カーソルを文字が存在しない部分でも動けるようにする
set switchbuf=useopen " 新しく開く代わりにすでに開いてあるバッファを開く
set showmatch " 対応する括弧などをハイライト表示する
set matchtime=3 " 対応括弧のハイライト表示を3秒にする
set backspace=indent,eol,start " バックスペースでなんでも消せるようにする
set pastetoggle=<F12> " F12でインサートモードでpaste modeをトグル
set clipboard=unnamedplus  " yankでクリップボードにコピー

" バックアップ
set nowritebackup
set nobackup " ~ファイルを作らない
set noswapfile

" https://stackoverflow.com/questions/10590165/is-there-a-way-in-vim-to-make-w-to-do-the-same-thing-as-w
command! W :w
command! Q :q
command! Wq :wq

" Highlight
set hlsearch
noremap <C-n> :nohl<CR>
vnoremap <C-n> :nohl<CR>
inoremap <C-n> :nohl<CR>

" Copy selected text to clipboard (need to use vim of gvim)
set clipboard=unnamedplus

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

" Tab補完をwindowっぽく
nnoremap <C-t><C-t> :tabprevious<CR>
inoremap <C-t><C-t> <Esc>:tabprevious<CR>
nnoremap <C-t>h :tabprevious<CR>
inoremap <C-t>h <Esc>:tabprevious<CR>
nnoremap <C-t><C-h> :tabprevious<CR>
inoremap <C-t><C-h> <Esc>:tabprevious<CR>
nnoremap <C-t>l :tabnext<CR>
inoremap <C-t>l <Esc>:tabnext<CR>
nnoremap <C-t><C-l> :tabnext<CR>
inoremap <C-t><C-l> <Esc>:tabnext<CR>

" windowのResize(Tmux風)
nnoremap <C-w>H :vertical resize -5<cr>
nnoremap <C-w>J :resize +5<cr>
nnoremap <C-w>K :resize -5<cr>
nnoremap <C-w>L :vertical resize +5<cr>
nnoremap H :vertical resize -5<cr>
nnoremap J :resize +5<cr>
nnoremap K :resize -5<cr>
nnoremap L :vertical resize +5<cr>

" GUI
if has("gui_running")
    colorscheme slate
    set guifont=Hack
endif

