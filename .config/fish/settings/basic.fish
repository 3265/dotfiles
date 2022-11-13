#!/bin/fish

# basic path
export PATH=/bin:/usr/bin:/usr/local/bin:/sbin:/usr/sbin

export EDITOR=vim
export PAGER=less

export TERM=xterm-256color # iTermのときの設定

# Editor
export CVSEDITOR=$EDITOR
export SVN_EDITOR=$EDITOR
export GIT_EDITOR=$EDITOR
export LESSCHARSET=utf-8 # git logの文字化け対策

# Ls Color
export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export CLICOLOR=true # lsコマンド時、自動で色がつく(ls -Gのようなもの？)

# History
# export HISTFILE=~/.zsh_history # History file
export HISTSIZE=10000          # History size in memory
export SAVEHIST=1000000        # The number of histsize
export LISTMAX=100              # The size of asking history

# XDG_Config (FISHだと、shellを開始開始した所に~がつくられるのでコメントアウト)
# export XDG_CONFIG_HOME=~/.config

# Disable Gnu Screen C-x screen locking
# ref: https://www.pantz.org/software/screen/disabling_gnu_screen_lock_screen.html#:~:text=Disabling%20lock%20screen&text=The%20way%20I%20found%20to,and%20start%20a%20new%20one.
export LOCKPRG=/bin/true

# lunch screen
export LC_CTYPE=en_US.UTF-8 # NOTE: for prevending bug of gnu screen

# screen dir
export SCREENDIR=$HOME/.screen

# for WSL
export GPG_TTY=$(tty)
