"--------------------------
" NeoBundle Settings.
"--------------------------
" bundle start
set runtimepath+=~/.vim/bundle/neobundle.vim/
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

" NERDTree(ctrl-eで開く)
NeoBundle 'scrooloose/nerdtree'
nnoremap <silent><C-e> :NERDTreeToggle<CR>
" オートセーブ機能(200ms or insertmode抜けると自動保存される)
NeoBundle 'vim-scripts/vim-auto-save'
" ステータスライン
NeoBundle 'itchyny/lightline.vim'
set laststatus=2
" テーマ
NeoBundle 'altercation/vim-colors-solarized'
syntax enable
set background=dark
colorscheme solarized
" エディタコンフィグ
NeoBundle 'editorconfig/editorconfig-vim'

" bundle end
call neobundle#end()
filetype plugin indent on
NeoBundleCheck

"-------------------------
" End Neobundle Settings.
"-------------------------

" 隠しファイルをデフォルトで表示させる
let NERDTreeShowHidden = 1
" デフォルトオートセーブを有効にする
let g:auto_save = 1

"-----------------------------------------------------
"" 表示関係
"----------------------------------------------------
"編集中のファイル名を表示する
set title
" 行番号を表示しない
set number
" 挿入で勝手にインデントさせない
set paste
" 検索結果文字列のハイライトを有効にする
set hlsearch
" コマンドライン補完を拡張モードにする
set wildmenu
" 入力されているテキストの最大幅(行がそれより長くなると、この幅を超えないように空白の後で改行される)を無効にする
set textwidth=0
" ウィンドウの幅より長い行は折り返して、次の行に続けて表示する
set wrap


"---------------------------------------------------
"" インデント
"----------------------------------------------------
" タブが対応する空白の数
set tabstop=2
" タブやバックスペースの使用等の編集操作をするときに、タブが対応する空白の数
set softtabstop=2
" インデントの各段階に使われる空白の数
set shiftwidth=2
" タブを挿入するとき、代わりに空白を使わない
set noexpandtab


"----------------------------------------------------
" その他
"----------------------------------------------------
"" バッファを切替えてもundoの効力を失わない
set hidden
" 起動時のメッセージを表示しない
set shortmess+=I
" 横線の表示
set cursorline
" 文字コードの自動判別
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
" 改行コードの自動認識
set fileformats=unix,dos,mac
" 不可視文字の可視化
set list
" 行番号の表示
set number
" 長い文字の折り返し
set wrap
" 80行目にライン入れる
set colorcolumn=80
" スクリーンベルを無効化
set t_vb=
set novisualbell
" デフォルト不可視文字は美しくないのでUnicodeで綺麗に
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲

"----------------------------------------------------
" 検索設定
"----------------------------------------------------
" 大文字小文字の区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" コマンドライン補完を有効にする
set wildmenu wildmode=list:full
" インクリメンタルサーチを有効化
set incsearch
" 検索マッチテキストをハイライト
set hlsearch
" バックスラッシュやクエスチョンを状況に合わせ自動的にエスケープ
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'


"----------------------------------------------------
" 編集設定
"----------------------------------------------------
" '<'や'>'でインデントする際に'shiftwidth'の倍数に丸める
set shiftround
" 補完時に大文字小文字を区別しない
set infercase
" カーソルを文字が存在しない部分でも動けるようにする
set virtualedit=all
" バッファを閉じる代わりに隠す（Undo履歴を残すため）
set hidden
" 新しく開く代わりにすでに開いてあるバッファを開く
set switchbuf=useopen
" 対応する括弧などをハイライト表示する
set showmatch
" 対応括弧のハイライト表示を3秒にする
set matchtime=3
" 対応括弧に'<'と'>'のペアを追加
set matchpairs& matchpairs+=<:>
" バックスペースでなんでも消せるようにする
set backspace=indent,eol,start
" 全て無効化する
set nowritebackup
set nobackup
set noswapfile
" マークダウンの色付け
set syntax=markdown
au BufRead,BufNewFile *.md set filetype=markdown
" Thanks for Flying Vimを消す
set notitle
