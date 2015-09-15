" vimrc

" Vundle start
set nocompatible " Required
filetype off
set rtp+=~/.vim/vundle.git
call vundle#rc()

Plugin 'Shougo/neocomplcache' " 文字入力の保管
Plugin 'scrooloose/nerdtree' "finder
Plugin 'Xuyuanp/nerdtree-git-plugin' " findler git diff
Plugin 'itchyny/lightline.vim' " ステータスライン
Plugin 'editorconfig/editorconfig-vim' " エディターコンフィグ
Plugin 'moll/vim-node' " gfでrequire移動用
Plugin 'airblade/vim-gitgutter' " ファイルのgit diff
Plugin 'nathanaelkane/vim-indent-guides' " インデントを見やすく
Plugin 'scrooloose/syntastic.git' " シンタックスチェック
Plugin 'altercation/vim-colors-solarized' " カラーテーマ
Plugin 'Shougo/unite.vim'
Plugin 'Shougo/neocomplcache.vim' " 自動補完用(completeはlua必要のため見送り)
Plugin 'Shougo/neosnippet'
Plugin 'Shougo/neosnippet-snippets'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'osyo-manga/vim-over'
Plugin 'digitaltoad/vim-jade'
Plugin 'groenewege/vim-less'
Plugin 'heavenshell/vim-jsdoc'
Plugin 'stephpy/vim-yaml'
Plugin 'pangloss/vim-javascript' " jsのシンタックス
Plugin 'myhere/vim-nodejs-complete'
Plugin 'marijnh/tern_for_vim' " jsの用語

" Vundle end
call vundle#end()
filetype plugin indent on

" macvim.app
if has("gui_running")
	set guifont=Monaco:h13 "フォント
	set imdisable "IM をオフ
	set transparency=10 " 透明度
	set fuoptions=maxvert,maxhorz " 画面を最大化
	au GUIEnter * set fullscreen
endif

" キーマッピング
nnoremap <silent><C-e> :NERDTreeToggle<CR> " ファインダー
nnoremap <ESC><ESC> :nohlsearch<CR> " シンタックスハイライト

" カッコの補完
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap [<Enter> []<Left><CR><ESC><S-o>
inoremap (<Enter> ()<Left><CR><ESC><S-o>

" 見栄えの設定
let NERDTreeShowHidden = 1 " 隠しフォルダを表示する
let g:lightline = {
	\ 'colorscheme': 'wombat'
	\ }
" let g:auto_save = 0 " オートセーブを有効か

" シンタックスチェック
let g:syntastic_check_on_open=0
let g:syntastic_check_on_save=1
let g:syntastic_auto_loc_list=1
let g:syntastic_loc_list_height=6
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_mode_map = {
	\ 'mode': 'active',
	\ 'active_filetypes': ['javascript'],
	\ 'passive_filetypes': []
	\ }
let g:syntastic_enable_signs=1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'

" vim-indent-guides
let g:indent_guides_auto_colors=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd   ctermbg=240 " dark
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven  ctermbg=240 " dark
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_guide_size=1 " ガイドの幅
let g:indent_guides_color_change_percent = 10

" neeComplete
let g:acp_enableAtStartup = 0
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_min_syntax_length = 3

" オムニ補完
autocmd! FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd! FileType eruby,html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd! FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd! FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd! FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" 機能系
set autoread " 開いているファイルに変更があったら即リローロド
set scrolloff=5 " スクロール行数
set title " 編集中のファイル名の表示
set notitle " Thanks for Flying Vimを消す
set textwidth=0 " 途中改行させない
set wrap " ウィンドウ幅より長い行は折り返して次の行に続けて表示する
set hidden " バッファを切替えてもundoの効力を失わない
set visualbell t_vb= " 画面フラッシュを無効化
set noerrorbells " エラーメッセージの表示時にビープを鳴らさない
" set paste " 挿入で勝手にインデントさせない(補完できなくなるので無効)

" タブ関連
set tabstop=4 " 画面上でタブが占める幅
set shiftwidth=4 " 自動インデントでずれる幅
set softtabstop=4 " 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set smartindent "改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set autoindent "改行時に前の行のインデントを継続する
set noexpandtab " タブをスペースに置き換えない
" set extendtab " タブをスペースに置き換える

" 表示系
syntax enable " 構文ハイライト有効化
set laststatus=2
set showtabline=2 "タブを常に表示する
set cmdheight=1 "コマンドラインは1行
set shortmess+=I " 起動時のメッセージを表示しない
set cursorline " 横線の表示
set encoding=utf-8 " 文字コード
set fileformats=unix,dos,mac " 改行コードの自動認識
set number " 行番号を表示する
set colorcolumn=100 " 100行目にラインをいれる
set t_vb= " ピープ音を消す
set novisualbell " ビジュアルベルの無効化
" 不可視文字を綺麗にする
set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
syntax enable
set t_Co=256 " 256色
set background=dark " 背景色
let g:solarized_termcolors=256
let g:solarized_termtrans=1
colorscheme solarized

" 検索
set ignorecase " 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase " 検索時に最後まで行ったら最初に戻る
set wrapscan " コマンドライン補完を有効にする
set wildmenu wildmode=list:full " インクリメンタルサーチを有効化
set incsearch " 検索マッチテキストをハイライト
set hlsearch " バックスラッシュやクエスチョンを状況に合わせ自動的にエスケープ
set infercase " 補完時に大文字小文字を区別しない
set virtualedit=all " カーソルを文字が存在しない部分でも動けるようにする
set switchbuf=useopen " 新しく開く代わりにすでに開いてあるバッファを開く
set showmatch " 対応する括弧などをハイライト表示する
set matchtime=3 " 対応括弧のハイライト表示を3秒にする
set backspace=indent,eol,start " バックスペースでなんでも消せるようにする

" バックアップ
set nowritebackup
set nobackup " ~ファイルを作らない
set noswapfile
