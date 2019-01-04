# ------------------------------
# Autoload settings
# ------------------------------

autoload -Uz run-help
autoload -Uz add-zsh-hook             # hook関数をロード
autoload -Uz colors; colors           # カラーをロード
autoload -Uz compinit; compinit -u    # 補完を開始(さいつよ)
autoload predict-on; predict-on       # 予測有効(超有能)
autoload -Uz is-at-least              #
autoload zed                          # zedを使用する
autoload -Uz vcs_info                 # vcs_infoをロード
autoload history-search-end
autoload -U tetris; zle -N tetris
autoload -U compinit; compinit        # lsの色
autoload bashcompinit                 # to avoid err command not found: complete
bashcompinit

# ------------------------------
# General Settings
# ------------------------------

export EDITOR=vim        # エディタをvimに設定
export PAGER=less        # PagerはLESS
export KCODE=u           # KCODEにUTF-8を設定
export AUTOFEATURE=true  # autotestでfeatureを動かす

# Language
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

export TERM=xterm-256color # iTermのときの設定

# Editor
export CVSEDITOR="${EDITOR}"
export SVN_EDITOR="${EDITOR}"
export GIT_EDITOR="${EDITOR}"
export LESSCHARSET=utf-8 # git logの文字化け対策

### Ls Color
export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export ZLS_COLORS=$LS_COLORS # ZLS_COLORSとは？
export CLICOLOR=true # lsコマンド時、自動で色がつく(ls -Gのようなもの？)
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS} # 補完候補に色を付ける

# History
export HISTFILE=~/.zsh_history # History file
export HISTSIZE=10000          # History size in memory
export SAVEHIST=1000000        # The number of histsize
export LISTMAX=50              # The size of asking history

# 3秒以上コマンドに時間がかかったら詳細表示
export REPORTTIME=3

# for nvim
export XDG_CONFIG_HOME=~/.config

# ------------------------------
# Programming Languager Settings
# ------------------------------

# Anyenv
# if [ -d ${HOME}/.anyenv ] ; then
#   export PATH="$HOME/.anyenv/bin:$PATH"
#   eval "$(anyenv init -)"
# fi
#

# Direnv
if [ $(which direnv) ]; then
  eval "$(direnv hook zsh)"
fi

# Ruby Env
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# Android
export ANDROID_HOME=${HOME}/Android/Sdk
export PATH=${PATH}:${ANDROID_HOME}/tools
export PATH=${PATH}:${ANDROID_HOME}/platform-tools

# Golang
export GOPATH=$HOME/.go
export PATH=$PATH:$GOROOT:$GOPATH:$GOPATH/bin


# ------------------------------
# Auto added
# ------------------------------

# Anaconda3
export PATH="/home/mgoldchild/anaconda3/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/mgoldchild/google-cloud-sdk/path.zsh.inc' ]; then source '/home/mgoldchild/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/mgoldchild/google-cloud-sdk/completion.zsh.inc' ]; then source '/home/mgoldchild/google-cloud-sdk/completion.zsh.inc'; fi

