"--------------------------
" NeoBundle Settings.
"--------------------------

" bundleで管理するディレクトリを指定
set runtimepath+=~/.vim/bundle/neobundle.vim/

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

"neobundle自体をneobundleで管理
NeoBundleFetch 'Shougo/neobundle.vim'

" NERDTreeを設定
NeoBundle 'scrooloose/nerdtree'
" ショートカット（キーマップ）ctrl+eでオープン
nnoremap <silent><C-e> :NERDTreeToggle<CR>

" オートセーブ機能(200ms or insertmode抜けると自動保存される)
NeoBundle 'vim-scripts/vim-auto-save'

" 色の変更
"NeoBundle 'altercation/vim-colors-solarized'
" Solarized Settings
syntax enable
set background=dark


" ステータスライン
NeoBundle 'itchyny/lightline.vim'
set laststatus=2
" jsの補完

" vimfiler
" NeoBundle 'Shougo/unite.vim'
" NeoBundle 'Shougo/vimfiler'
" NeoBundle 'Shougo/vimproc'


" 今後このあたりに追加のプラグインをどんどん書いて行きます！！"
call neobundle#end()

" Required:
filetype plugin indent on

" 色を変更
" colorscheme solarized

" 未インストールのプラグインがある場合、インストールするかどうかを尋ねてくれるようにする設定
" 毎回聞かれると邪魔な場合もあるので、この設定は任意です。
NeoBundleCheck

"-------------------------
" End Neobundle Settings.
"-------------------------

" 最初からNerdTreeを表示
" autocmd VimEnter * execute 'NERDTree'

" 隠しファイルをデフォルトで表示させる
let NERDTreeShowHidden = 1

" デフォルトオートセーブを有効にする
let g:auto_save = 1

" lightlineの-- INSERT (paste) -- を消す
"set noshowmode

"-----------------------------------------------------
"" 表示関係
"----------------------------------------------------
"編集中のファイル名を表示する
set title
" 行番号を表示しない
set number
" ルーラーを表示
" set ruler
" タブ文字を CTRL-I で表示し、行末に $ で表示する
" set list
" 入力中のコマンドをステータスに表示する
" set showcmd
" ステータスラインを常に表示
" set laststatus=2
" 括弧入力時の対応する括弧を表示
" set showmatch
" 対応する括弧の表示時間を2にする
" set matchtime=2
" シンタックスハイライトを有効にする
" syntax on
" 挿入で勝手にインデントさせない
set paste
" 検索結果文字列のハイライトを有効にする
set hlsearch
" コメント文の色を変更
" highlight Comment ctermfg=DarkCyan
" コマンドライン補完を拡張モードにする
set wildmenu
" " 入力されているテキストの最大幅
" (行がそれより長くなると、この幅を超えないように空白の後で改行される)を無効にする
set textwidth=0
" " ウィンドウの幅より長い行は折り返して、次の行に続けて表示する
set wrap
""新しい行を作った時に高度な自動インデントを行う
" set smarttab


"----------------------------------------------------
"   マッピング
"----------------------------------------------------
" escが遠いので代用する。
"noremap <C-j> <esc>
"noremap! <C-j> <esc>
" 設定変更のショートカット (space + .)
nnoremap <Space>. :<C-u>tabedit $MYVIMRC<CR>


"---------------------------------------------------
"" インデント
"----------------------------------------------------
"" オートインデントを無効にする
" set noautoinden
" タブが対応する空白の数
set tabstop=4
" タブやバックスペースの使用等の編集操作をするときに、タブが対応する空白の数
set softtabstop=4
" " インデントの各段階に使われる空白の数
set shiftwidth=4
" " タブを挿入するとき、代わりに空白を使わない
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
" 縦線の表示
" set cursorcolumn
" カーソルの色替え
" highlight CursorColumn ctermbg=Darkgray
" highlight CursorColumn ctermfg=Green
" highlight CursorLine ctermbg=Black
" highlight CursorLine ctermfg=Blue

"----------------------------------------------------
" その他2
"----------------------------------------------------
" 文字コードの自動判別
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
" 改行コードの自動認識
set fileformats=unix,dos,mac
" バックアップファイルの場所指定
" set backupdir=$HOME/vimbackup
" スワップファイル用のディレクトリ指定
" set directory=$HOME/vimbackup
" クリップボードをWindowsと連携する
set clipboard=unnamed
"インクリメンタルサーチを行う
" grep検索を設定する
" set grepformat=%f:%l:%m,%f:%l%m,%f\ \ %l%m,%f
" set grepprg=grep\ -n


"----------------------------------------------------
" その他
"----------------------------------------------------
set list                " 不可視文字の可視化
set number              " 行番号の表示
set wrap                " 長いテキストの折り返し
" set textwidth=0         " 自動的に改行が入るのを無効化
" set colorcolumn=80      " その代わり80文字目にラインを入れる

" 前時代的スクリーンベルを無効化
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
set shiftround          " '<'や'>'でインデントする際に'shiftwidth'の倍数に丸める
set infercase           " 補完時に大文字小文字を区別しない
set virtualedit=all     " カーソルを文字が存在しない部分でも動けるようにする
set hidden              " バッファを閉じる代わりに隠す（Undo履歴を残すため）
set switchbuf=useopen   " 新しく開く代わりにすでに開いてあるバッファを開く
set showmatch           " 対応する括弧などをハイライト表示する
set matchtime=3         " 対応括弧のハイライト表示を3秒にする

" 対応括弧に'<'と'>'のペアを追加
set matchpairs& matchpairs+=<:>

" バックスペースでなんでも消せるようにする
set backspace=indent,eol,start

" クリップボードをデフォルトのレジスタとして指定。後にYankRingを使うので
" 'unnamedplus'が存在しているかどうかで設定を分ける必要がある
if has('unnamedplus')
    " set clipboard& clipboard+=unnamedplus " 2013-07-03 14:30 unnamed 追加
    set clipboard& clipboard+=unnamedplus,unnamed
else
    " set clipboard& clipboard+=unnamed,autoselect 2013-06-24 10:00 autoselect 削除
    set clipboard& clipboard+=unnamed
endif

" Swapファイル？Backupファイル？前時代的すぎ
" なので全て無効化する
set nowritebackup
set nobackup
set noswapfile

"----------------------------------------------------
" 保存関連
"----------------------------------------------------
" 保存時に行末の空白を除去する(マークダウンの文末の空白が効かなくなるので無効化)
" autocmd BufWritePre * :%s/\s\+$//ge

"----------------------------------------------------
" マークダウンの色付け
"----------------------------------------------------
set syntax=markdown
au BufRead,BufNewFile *.md set filetype=markdown


"----------------------------------------------------
"" 関数
"----------------------------------------------------
" 全角スペース・行末のスペース・タブの可視化


" sintastics
"let g:syntastic_check_on_open=0
"let g:syntastic_check_on_save=1
"let g:syntastic_auto_loc_list=1
"let g:syntastic_loc_list_height=6
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"let g:syntastic_javascript_checkers = ['jshint']
"let g:syntastic_mode_map = {
"      \ 'mode': 'active',
"      \ 'active_filetypes': ['javascript'],
"      \ 'passive_filetypes': []
"      \ }
"let g:syntastic_enable_signs=1
"let g:syntastic_error_symbol='→'
"let g:syntastic_warning_symbol='→'

" lightline.vimの設定

" export TERM=xterm-256color
" if !has('gui_running')
"  set t_Co=256
" endif

"let g:lightline = {
"      \ 'colorscheme': 'solarized'
"      \

" ------------------------
"  マクロなどの設定
" ------------------------


" 入力モード中に素早くjjと入力した場合はESCとみなす
" inoremap jj <Esc>

" ESCを二回押すことでハイライトを消す
" nmap <silent> <Esc><Esc> :nohlsearch<CR>

" カーソル下の単語を * で検索
"vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>

" 検索後にジャンプした際に検索単語を画面中央に持ってくる
" nnoremap n nzz
" nnoremap N Nzz
" nnoremap * *zz
" nnoremap # #zz
" nnoremap g* g*zz
" nnoremap g# g#zz

" j, k による移動を折り返されたテキストでも自然に振る舞うように変更
" nnoremap j gj
" nnoremap k gk

" vを二回で行末まで選択
" vnoremap v $h

" TABにて対応ペアにジャンプ
" vnoremap <Tab> %
" vnoremap <Tab> %

" Ctrl + hjkl でウィンドウ間を移動
" nnoremap <C-h> <C-w>h
"  nnoremap <C-j> <C-w>j
" nnoremap <C-k> <C-w>k
" nnoremap <C-l> <C-w>l

" Shift + 矢印でウィンドウサイズを変更
" nnoremap <S-Left>  <C-w><<CR>
" nnoremap <S-Right> <C-w>><CR>
" nnoremap <S-Up>    <C-w>-<CR>
" nnoremap <S-Down>  <C-w>+<CR>

" T + ? で各種設定をトグル
" nnoremap [toggle] <Nop>
" nmap T [toggle]
" nnoremap <silent> [toggle]s :setl spell!<CR>:setl spell?<CR>
" nnoremap <silent> [toggle]l :setl list!<CR>:setl list?<CR>
" nnoremap <silent> [toggle]t :setl expandtab!<CR>:setl expandtab?<CR>
" nnoremap <silent> [toggle]w :setl wrap!<CR>:setl wrap?<CR>

" make, grep などのコマンド後に自動的にQuickFixを開く
"autocmd MyAutoCmd QuickfixCmdPost make,grep,grepadd,vimgrep copen

" QuickFixおよびHelpでは q でバッファを閉じる
"autocmd MyAutoCmd FileType help,qf nnoremap <buffer> q <C-w>c

" w!! でスーパーユーザーとして保存（sudoが使える環境限定）
" cmap w!! w !sudo tee > /dev/null %




" Thanks for Flying Vimを消す
set notitle

let &titleold=getcwd()
