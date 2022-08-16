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

# コマンドラインを任意のエディタで編集する(bindは.zshrc.keybinding)
autoload -Uz edit-command-line
zle -N edit-command-line

bashcompinit

# ------------------------------
# General Settings
# ------------------------------

export EDITOR=vim
export PAGER=less
export KCODE=u          # KCODEにUTF-8を設定
export AUTOFEATURE=true # autotestでfeatureを動かす

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
export LISTMAX=100              # The size of asking history

# 3秒以上コマンドに時間がかかったら詳細表示
export REPORTTIME=3

# for nvim
export XDG_CONFIG_HOME=~/.config

# ------------------------------
# Programming Language Settings
# ------------------------------

# Anyenv
# if [ -d ${HOME}/.anyenv ] ; then
#   export PATH="$HOME/.anyenv/bin:$PATH"
#   eval "$(anyenv init -)"
# fi
#

# Direnv
if type "direnv" > /dev/null; then
  eval "$(direnv hook zsh)"
fi

# Binary
# NOTE: Personal binary place instead of /usr/local/bin/ due to permission
# ref: 
# - https://superuser.com/questions/1289534/how-to-install-when-permission-denied-to-usr-local-bin
# - https://stackoverflow.com/questions/793858/how-to-mkdir-only-if-a-dir-does-not-already-exist
if [[ ! -e ~/bin ]]; then
    mkdir ~/bin
fi
export PATH="$HOME/bin:$PATH"

# JAVA
if type "java" > /dev/null; then
  export JAVA_HOME=$(readlink -f /usr/bin/javac | sed "s:/bin/javac::")
  export PATT=$PATH:$JAVA_HOME/bin
fi

# Ruby Env
if type "rbenv" > /dev/null; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

# Android
export ANDROID_HOME=${HOME}/Android/Sdk
export PATH=${PATH}:${ANDROID_HOME}/tools
export PATH=${PATH}:${ANDROID_HOME}/platform-tools

# Golang
if type "go" > /dev/null; then
  export GOPATH=$HOME/.go
  export PATH=$PATH:$GOROOT:$GOPATH:$GOPATH/bin
fi

# ------------------------------
# Another Settings
# ------------------------------

# FZF
if type "fzf" > /dev/null; then
  export FZF_DEFAULT_OPTS="--bind ctrl-d:page-down,ctrl-u:page-up --reverse --inline-info --prompt='λ> ' --preview 'cat {}'"
  export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""' # see https://github.com/junegunn/fzf/issues/634
fi

# ------------------------------
# Auto added
# ------------------------------

# Anaconda3
export PATH="/home/mike/anaconda3/bin:$PATH"

# lunch screen
export LC_CTYPE=en_US.UTF-8 # NOTE: for prevending bug of gnu screen

export CLOUDSDK_PYTHON=python2

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/mike/google-cloud-sdk/path.zsh.inc' ]; then source '/home/mike/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/mike/google-cloud-sdk/completion.zsh.inc' ]; then source '/home/mike/google-cloud-sdk/completion.zsh.inc'; fi

# perl
if type "perl" > /dev/null; then
  PATH="/home/mike/perl5/bin${PATH:+:${PATH}}"; export PATH;
  PERL5LIB="/home/mike/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
  PERL_LOCAL_LIB_ROOT="/home/mike/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
  PERL_MB_OPT="--install_base \"/home/mike/perl5\""; export PERL_MB_OPT;
  PERL_MM_OPT="INSTALL_BASE=/home/mike/perl5"; export PERL_MM_OPT;
fi

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

# Rust
export PATH=$PATH:~/.cargo/bin/

# NVM
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Autojump
source /usr/share/autojump/autojump.zsh

# Jetson 
if [ -d /usr/local/cuda-10.2 ] ; then
  export PATH=/usr/local/cuda-10.2/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin:~/.local/bin
  export LD_LIBRARY_PATH=/usr/local/cuda-10.2/lib64:
fi

# for pipenv on ubuntu
export PATH="$HOME/.local/bin:$PATH"

# for WSL
export GPG_TTY=$(tty)

# screen dir
export SCREENDIR=$HOME/.screen

# for VCPKG
if [ -d ~/vcpkg/ ] ; then
    export PATH=~/vcpkg/:$PATH
fi

# root
if [ -d ~/root/ ] ; then
    export PATH=~/root/bin:$PATH
fi

POETRY_FOLDER=$HOME/.poetry
if [ -d "$POETRY_FOLDER" ]; then
    source $HOME/.poetry/env
fi
