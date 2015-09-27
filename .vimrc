" vimrc

" ==============================================
" vunlde
" ==============================================

" Vundle start
set nocompatible " Required
filetype off
set rtp+=~/.vim/vundle.git
call vundle#rc()

Plugin 'scrooloose/nerdtree' " filetree
Plugin 'Xuyuanp/nerdtree-git-plugin' " filetree git diff
Plugin 'ryanoasis/vim-devicons' " filetree file icon
Plugin 'tpope/vim-fugitive' " ステータスラインにブランチ名表示する
Plugin 'bling/vim-airline' " ステータスライン
Plugin 'airblade/vim-gitgutter' " ファイルのgit diff
Plugin 'nathanaelkane/vim-indent-guides' " インデントを見やすく
Plugin 'altercation/vim-colors-solarized' " カラーテーマ
Plugin 'scrooloose/syntastic.git' " シンタックスチェック

Plugin 'majutsushi/tagbar' " ctags用のタグバー
Plugin 'soramugi/auto-ctags.vim' " ctagsの自動保存
Plugin 'editorconfig/editorconfig-vim' " エディターコンフィグ

Plugin 'kien/ctrlp.vim' " peco的な
Plugin 'Shougo/unite.vim' " peco的に使う
Plugin 'osyo-manga/vim-over' "
Plugin 'haya14busa/incsearch.vim' " インクリメンタルサーチ用
Plugin 'tyru/caw.vim.git' " コメント用プラグイン

Plugin 'Shougo/neocomplcache.vim' " 自動補完用(completeはlua必要のため見送り)
Plugin 'Shougo/neosnippet.vim' " スニペット用
Plugin 'Shougo/neosnippet-snippets' " スニペット用

Plugin 'mustache/vim-mustache-handlebars' " hbs
Plugin 'hail2u/vim-css3-syntax' " css
Plugin 'digitaltoad/vim-jade'  " jade
Plugin 'groenewege/vim-less' " less
Plugin 'stephpy/vim-yaml' "yaml
Plugin 'elzr/vim-json' " json

Plugin 'pangloss/vim-javascript' " jsインデントとシンタックスカラー
Plugin 'mattn/jscomplete-vim' " jsの補完用
Plugin 'myhere/vim-nodejs-complete' " nodeの補完用
Plugin 'moll/vim-node' " gfでrequire移動用
Plugin 'heavenshell/vim-jsdoc' " jsdoc用

Plugin 'lambdalisue/vim-unified-diff' " git diff 用

" Vundle end
call vundle#end()
filetype plugin indent on

" ==============================================
" syntax check
" ==============================================

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
" jshint error symbol
let g:syntastic_enable_signs=1
let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = "✗"
let g:syntastic_style_error_symbol = "☢"

" vim-javascript
let g:javascript_enable_domhtmlcss = 1
let b:javascript_fold = 1
let g:javascript_ignore_javaScriptdoc = 1
let g:javascript_conceal_function   = "ƒ"
let g:javascript_conceal_null       = "ø"
let g:javascript_conceal_this       = "@"
let g:javascript_conceal_return     = "⇚"
let g:javascript_conceal_undefined  = "¿"
let g:javascript_conceal_NaN        = "ℕ"
let g:javascript_conceal_prototype  = "¶"
let g:javascript_conceal_static     = "•"
let g:javascript_conceal_super      = "Ω"


" ==============================================
" colorscheme
" ==============================================

"" Solarized
let g:solarized_termcolors=256
let g:solarized_termtrans=1
let g:solarized_degrade = 0
let g:solarized_termcolors = 256
let g:solarized_termtrans = 1
let g:solarized_bold = 1
let g:solarized_underline = 1
let g:solarized_italic = 1
let g:solarized_contrast = 'normal'
let g:solarized_visibility = 'normal'
colorscheme solarized

" ==============================================
" tab & statusline
" ==============================================

" status line
let g:airline_theme = 'solarized'
let g:airline#extensions#hunks#enabled=0
let g:airline#extensions#branch#enabled=1
let g:airline_left_sep = '▶'
let g:airline_left_alt_sep = '»'
let g:airline_right_sep = '◀'
let g:airline_right_alt_sep = '«'

" detected
"let g:airline_linecolumn_prefix = '␤ '
"let g:airline_linecolumn_prefix = '¶ '
"let g:airline_branch_prefix = '⎇ '
"let g:airline_paste_symbol = 'ρ'
"let g:airline_paste_symbol = 'Þ'
"let g:airline_paste_symbol = '∥'

" tab
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0 " タブにバッファ表示しない
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#left_sep = '▶'
let g:airline#extensions#tabline#left_alt_sep = '◀'

" ==============================================
" left git diff bar
" ==============================================
"
let g:gitgutter_sign_added = '✚'
let g:gitgutter_sign_modified = '➜'
let g:gitgutter_sign_removed = '✘'

" ==============================================
" filetree
" ==============================================

" nerdtree icon settings
let NERDTreeShowHidden = 1 " 隠しフォルダを表示する

" nerdtree git
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "編",
    \ "Staged"    : "追",
    \ "Untracked" : "逃",
    \ "Renamed"   : "名",
    \ "Unmerged"  : "未",
    \ "Deleted"   : "削",
    \ "Dirty"     : "変",
    \ "Clean"     : "良",
    \ "Unknown"   : "謎"
    \ }

" nerdtree icon
let g:WebDevIconsNerdTreeAfterGlyphPadding = ' ' " アイコンのパディング
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1

" auto refresh nerdtre 15s
set autoread
au CursorHold * if exists("t:NerdTreeBufName") | call <SNR>15_refreshRoot() | endif

" ==============================================
" indent guide
" ==============================================

" vim-indent-guides
let g:indent_guides_auto_colors=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd   ctermbg=darkgrey
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven  ctermbg=grey
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_guide_size=1 " ガイドの幅
let g:indent_guides_color_change_percent = 10

" ==============================================
" auto completion
" ==============================================

let g:acp_enableAtStartup = 0
let g:neocomplcache_enable_at_startup = 1 " neocomplcacheを有効化
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_min_syntax_length = 3

autocmd FileType javascript setlocal omnifunc=nodejscomplete#CompleteJS
if !exists('g:neocomplcache_omni_functions')
	let g:neocomplcache_omni_functions = {}
endif
let g:neocomplcache_omni_functions.javascript = 'nodejscomplete#CompleteJS'
let g:node_usejscomplete = 1
" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif


" fileタイプごとのomni補完を指定
"autocmd! FileType css setlocal omnifunc=csscomplete#CompleteCSS
"autocmd! FileType eruby,html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"autocmd! FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"autocmd! FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Define dictionary.
"let g:neocomplcache_dictionary_filetype_lists = {
"    \ 'default' : ''
"    \ }

" ==============================================
" key mapping
" ==============================================

map! <NUL> <CR>
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap [<Enter> []<Left><CR><ESC><S-o>
inoremap (<Enter> ()<Left><CR><ESC><S-o>
nnoremap <ESC><ESC> :nohlsearch<CR> " シンタックスハイライトを消す

" タグジャンプ
nnoremap <C-h> :vsp<CR> :exe("tjump ".expand('<cword>'))<CR>
nnoremap <C-k> :split<CR> :exe("tjump ".expand('<cword>'))<CR>

" emacs風に
"imap <C-k> <ESC>d$i
"imap <C-y> <ESC>pi
"imap <C-d> <ESC>xi
"imap <C-a> <Home>
"imap <C-e> <End>
"imap <C-b> <Left>
"imap <C-f> <Right>
"imap <C-n> <Down>
"imap <C-p> <UP>

" tab
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


" 修羅の道
vnoremap <Up> <Nop>
vnoremap <Down> <Nop>
vnoremap <Left> <Nop>
vnoremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" snippets 実行
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
" necomplcacheのタブ
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" nerdtree
nnoremap <silent><C-e> :NERDTreeToggle<CR>
" tagbar window
nmap <F8> :TagbarToggle<CR>
" vim-node file jump
autocmd User Node
  \ if &filetype == "javascript" |
  \   nmap <buffer> <C-w>f <Plug>NodeVSplitGotoFile |
  \   nmap <buffer> <C-w><C-f> <Plug>NodeVSplitGotoFile |
  \ endif
" jsdoc
nmap <silent> <C-l> <Plug>(jsdoc)
" unite grep検索
nnoremap <silent> ,g  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
" uniteカーソル位置の単語をgrep検索
nnoremap <silent> ,cg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>
" unite grep検索結果の再呼出
nnoremap <silent> ,r  :<C-u>UniteResume search-buffer<CR>

" インクリメンタルサーチ
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" コメントアウト用
nmap <C-i> <Plug>(caw:i:toggle)
vmap <C-i> <Plug>(caw:i:toggle)

" ==============================================
" gvim
" ==============================================

if has("gui_running")
	set guifont=Monaco:h13 "フォント
	set imdisable "IM をオフ
	set transparency=10 " 透明度
	set fuoptions=maxvert,maxhorz " 画面を最大化
	au GUIEnter * set fullscreen
endif

" ==============================================
" ctags
" ==============================================

let g:auto_ctags = 1 " ctag自動保存
let g:auto_ctags_directory_list = ['.git', '.svn'] " gitdirに保存
let g:auto_ctags_tags_name = 'tags' " 名前
let g:auto_ctags_tags_args = '--tag-relative --recurse --sort=yes'
let g:auto_ctags_filetype_mode = 0 " ファイルタイプ専用のファイルは作らない

" ==============================================
" incremental file searcher
" ==============================================

" unite
let g:unite_enable_start_insert = 1 " insert modeで開始
let g:unite_enable_ignore_case = 1 " 大文字小文字の区別
let g:unite_enable_smart_case = 1
" unite grep に ag(The Silver Searcher) を使う
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif

" ctrlp
let g:ctrlp_use_migemo = 1
let g:ctrlp_clear_cache_on_exit = 0   " 終了時キャッシュをクリアしない
let g:ctrlp_mruf_max            = 500 " MRUの最大記録数
let g:ctrlp_open_new_file       = 1   " 新規ファイル作成時にタブで開く

" ==============================================
" incremental searcher
" ==============================================

let g:incsearch#magic = '\v' " magic

" ==============================================
" snippets
" ==============================================

" snippets directory
let g:neosnippet#snippets_directory='~/.vim/bundle/neosnippet-snippets/snippets/'
let g:nodejs_complete_config = {
	\  'js_compl_fn': 'jscomplete#CompleteJS',
	\  'max_node_compl_len': 15
	\}

" ==============================================
" vimdiff
" ==============================================

set diffexpr=unified_diff#diffexpr()

" configure with the followings (default values are shown below)
let unified_diff#executable = 'git'
let unified_diff#arguments = [
      \   'diff', '--no-index', '--no-color', '--no-ext-diff', '--unified=0',
      \ ]
let unified_diff#iwhite_arguments = [
      \   '--ignore--all-space',
      \ ]

" ==============================================
" common settings
" ==============================================

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
set timeout timeoutlen=1000 ttimeoutlen=75 " escの反応を早くする
set tags+=.git/tags " タグの管理
set switchbuf=usetab " 同じファイルを別タブで開かないようにする

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
set list " 不可視文字の可視化
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:« ",nbsp:%
set t_Co=256 " 256色
set background=dark " 背景色
" 全角スペース可視化
highlight JpSpace cterm=underline ctermfg=Yellow guifg=Yellow
au BufRead,BufNew * match JpSpace /　/

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
set pastetoggle=<F12> " F12でインサートモードでpaste modeをトグル
set clipboard=unnamedplus " 別タブでコピーを共有する

" バックアップ
set nowritebackup
set nobackup " ~ファイルを作らない
set noswapfile

