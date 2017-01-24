# zshrc

# ------------------------------
# General Settings
# ------------------------------
export EDITOR=vim        # エディタをvimに設定
export LANG=ja_JP.UTF-8  # 文字コードをUTF-8に設定
export KCODE=u           # KCODEにUTF-8を設定
export AUTOFEATURE=true  # autotestでfeatureを動かす

bindkey -e               # キーバインドをemacsモードに設定
#bindkey -v              # キーバインドをviモードに設定

setopt no_beep           # ビープ音を鳴らさないようにする
setopt auto_cd           # ディレクトリ名の入力のみで移動する
setopt auto_pushd        # cd時にディレクトリスタックにpushdする
setopt pushd_ignore_dups # 同じディレクトリを重複してpushしない。
setopt auto_param_keys   # カッコの対応などを自動的に補完
setopt auto_param_slash  # ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt correct           # コマンドのスペルを訂正する
setopt magic_equal_subst # =以降も補完する(--prefix=/usrなど)
setopt prompt_subst      # プロンプト定義内で変数置換やコマンド置換を扱う
setopt notify            # バックグラウンドジョブの状態変化を即時報告する
setopt equals            # =commandを`which command`と同じ処理にする

### Complement
autoload -U compinit; compinit                      # 補完機能を有効にする
autoload predict-on; predict-on                     # 予測有効(超有能)
setopt auto_list                                    # 補完候補を一覧で表示する(d)
setopt auto_menu                                    # 補完キー連打で補完候補を順に表示する(d)
setopt mark_dirs                                    # ファイル名の展開でディレクトリにマッチした場合 末尾に / を付加
setopt list_packed                                  # 補完候補をできるだけ詰めて表示する
setopt list_types                                   # 補完候補にファイルの種類も表示する
bindkey "^[[Z" reverse-menu-complete                # Shift-Tabで補完候補を逆順する("\e[Z"でも動作する)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 補完時に大文字小文字を区別しない
zstyle ':completion:*:default' menu select=1        # 補完候補のカーソル選択を有効に
setopt noautoremoveslash                            # 最後のスラッシュを自動的に削除しない
setopt interactive_comments                         # コマンドラインでも # 以降をコメントと見なす
setopt magic_equal_subst                            # コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる
setopt complete_in_word                             # 語の途中でもカーソル位置で補完
setopt always_last_prompt                           # カーソル位置は保持したままファイル名一覧を順次その場で表示
setopt print_eight_bit                              #日本語ファイル名等8ビットを通す
zstyle ':completion:*' list-separator '🐤 '          # オプション補完表示時とかのセパレータの設定

### Glob
setopt extended_glob # グロブ機能を拡張する
setopt globdots      # 明確なドットの指定なしで.から始まるファイルをマッチ
unsetopt caseglob    # ファイルグロブで大文字小文字を区別しない

### History
HISTFILE=~/.zsh_history   # ヒストリを保存するファイル
HISTSIZE=10000            # メモリに保存されるヒストリの件数
SAVEHIST=10000            # 保存されるヒストリの件数
setopt bang_hist          # !を使ったヒストリ展開を行う(d)
setopt extended_history   # ヒストリに実行時間も保存する
setopt hist_ignore_dups   # 直前と同じコマンドはヒストリに追加しない
setopt share_history      # 他のシェルのヒストリをリアルタイムで共有する
setopt hist_reduce_blanks # 余分なスペースを削除してヒストリに保存する
setopt hist_ignore_space # スペースで始まるコマンド行はヒストリリストから削除

# マッチしたコマンドのヒストリを表示できるようにする
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

### Other
setopt rmstar_wait                          # rm * を実行する前に確認される。
autoload -U colors; colors                  # 色の設定をロード
autoload zed                                # zedを使用する

# ------------------------------
# Look And Feel Settings
# ------------------------------
#
### Ls Color
export LSCOLORS=Exfxcxdxbxegedabagacad # 色の設定
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30' # 補完時の色の設定
export ZLS_COLORS=$LS_COLORS # ZLS_COLORSとは？
export CLICOLOR=true # lsコマンド時、自動で色がつく(ls -Gのようなもの？)
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS} # 補完候補に色を付ける

# ------------------------------
# Prompt settings
# ------------------------------

### VCS setting
autoload -Uz vcs_info # vcs_infoをロード
precmd () { vcs_info } # プロンプト表示直前に表示する

# VCS settings
zstyle ':vcs_info:*' enable git svn hg bzr # VCSを有効化
zstyle ':vcs_info:git:*' check-for-changes true #formats 設定項目で %c,%u が使用可
zstyle ':vcs_info:git:*' stagedstr "%F{green}!" #commit されていないファイルがある
zstyle ':vcs_info:git:*' unstagedstr "%F{magenta}+" #add されていないファイルがある
zstyle ':vcs_info:*' formats " %F{cyan}%c%u(%b)%f" #通常
zstyle ':vcs_info:*' actionformats '[%b|%a]' #rebase 途中,merge コンフリクト等 formats 外の表示

### Const
user_name="%n"
host_name="%m"
device_name="%y"
current_dir="%~"
current_dir_fullpath="%d"
current_dir_name="%C"
user_identifier="%#"
hh_mm="%T"
yy_mm_military="%t"
date_hyphen="%W"
date_slash="%w"
hh_mm_ss="%*"
yy_mm_dd="%D"
reset_color="%{${reset_color}%}"

### Colored Const
c_host_name="%{${fg[cyan]}%}${host_name}${reset_color}"
c_user_name="%{${fg[yellow]}%}${user_name}${reset_color}"
c_current_dir="%{${fg[green]}%}${current_dir}${reset_color}"
c_current_dir_fullpath="%{${fg[green]}%}${current_dir_fullpath}${reset_color}"
c_user_identifier="%{${fg[red]}%}${user_identifier}${reset_color}"  # if root { # } else { $ }
c_at_sign="%{${fg[white]}%}@%{${reset_color}%}"

# 一般ユーザ時
tmp_prompt="[${c_user_name}${c_at_sign}${c_host_name} ${c_current_dir}]"'${vcs_info_msg_0_}${c_user_identifier} '
tmp_prompt2="%{${fg[cyan]}%}%_> %{${reset_color}%}"
tmp_rprompt="[${c_current_dir_fullpath}]"
tmp_sprompt="%{${fg[yellow]}%}%r is correct? [Yes, No, Abort, Edit]:%{${reset_color}%}"

# rootユーザ時(太字にし、アンダーバーをつける)
if [ ${UID} -eq 0 ]; then
  tmp_prompt="%B%U${tmp_prompt}%u%b"
  tmp_prompt2="%B%U${tmp_prompt2}%u%b"
  tmp_rprompt="%B%U${tmp_rprompt}%u%b"
  tmp_sprompt="%B%U${tmp_sprompt}%u%b"
fi

PROMPT=$tmp_prompt    # 通常のプロンプト
PROMPT2=$tmp_prompt2  # セカンダリのプロンプト(コマンドが2行以上の時に表示される)
RPROMPT=$tmp_rprompt  # 右側のプロンプト
SPROMPT=$tmp_sprompt  # スペル訂正用プロンプト

# ------------------------------
# Function
# ------------------------------
# cdコマンド実行後、lsを実行する
function cd() {
 builtin cd $@ && ls;
}

# ------------------------------
# Alias Settings
# ------------------------------

emulate sh -c 'source ~/dotfiles/.aliases'

alias ..='cd ..'  #     <---- setopt AUTO_CDを設定してるので、本当はこれいらいない。
alias ...='cd ../..'
alias ....='cd ../../..'


