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
" set paste " 挿入で勝手にインデントさせない
set timeout timeoutlen=1000 ttimeoutlen=75 " escの反応を早くする
set switchbuf=usetab " 同じファイルを別タブで開かないようにする
set autoread " vimrc更新後に自動読み込み
set belloff=all " beepを鳴らさない
" see https://stackoverflow.com/questions/3961859/how-to-copy-to-clipboard-in-vim
set clipboard^=unnamed,unnamedplus " クリップボードにコピー

" タブ関連
" https://www.nims.go.jp/cmsc/staff/arai/python/python-vim.html
set tabstop=4 " 画面上でタブが占める幅
set shiftwidth=4 " 自動インデントでずれる幅
set softtabstop=4 " 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
" set smarttab
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
" set cursorcolumn " 縦線の表示
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
set pastetoggle=<F2> " Insertモードの時にF2でペーストモードのトグル

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

" Makefile tab
" https://superuser.com/questions/632657/how-to-setup-vim-to-edit-both-makefile-and-normal-code-files-with-two-different
autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0

" Netrw Settings
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

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

" WindowのResize (Tmux風)
nnoremap <C-w>H :vertical resize -5<cr>
nnoremap <C-w>J :resize +5<cr>
nnoremap <C-w>K :resize -5<cr>
nnoremap <C-w>L :vertical resize +5<cr>
nnoremap H :vertical resize -5<cr>
nnoremap J :resize +5<cr>
nnoremap K :resize -5<cr>
nnoremap L :vertical resize +5<cr>

" quick close
nnoremap Z ZZ<CR>
nnoremap q ZZ<CR>

" Nerdtree
map <C-e> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

" Marks
noremap <C-m> :marks<CR>

" leader key
let mapleader = "\<space>"
nnoremap <Leader>a :echo "Hello"<CR>

" vim-code-dark
colorscheme codedark

" fish
autocmd BufRead,BufNewFile *.fish set filetype=sh

" org-mode
let g:org_agenda_files = ['~/org/*.org', '~/Dropbox/org/*.org']
let g:org_todo_keywords = ['TODO', 'NEXT', '|', 'DONE']
" let g:org_heading_shade_leading_stars = 1
" let g:org_indent = 1

" プラグイン読み込み
filetype plugin indent on
