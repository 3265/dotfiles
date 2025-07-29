#!/bin/fish

# ------------------------------
# Bin
# ------------------------------

# NOTE: Personal binary place instead of /usr/local/bin/ due to permission
# ref:
# - https://superuser.com/questions/1289534/how-to-install-when-permission-denied-to-usr-local-bin
# - https://stackoverflow.com/questions/793858/how-to-mkdir-only-if-a-dir-does-not-already-exist
if not test -d ~/bin
    mkdir ~/bin
end
set -gx PATH "$HOME/bin" $PATH

# ------------------------------
# ClI
# ------------------------------

# Direnv
if type -q "direnv"
  eval "$(direnv hook fish)"
end

# FZF
if type -q "fzf"
  set FZF_DEFAULT_OPTS "--bind ctrl-d:page-down,ctrl-u:page-up --reverse --inline-info"
  set FZF_DEFAULT_COMMAND 'ag --hidden --ignore .git -g ""' # see https://github.com/junegunn/fzf/issues/634
end

# Autojump
source /usr/share/autojump/autojump.fish

# ------------------------------
# C/C++
# ------------------------------

# for VCPKG
if test -d ~/vcpkg/
    set -gx PATH ~/vcpkg/ $PATH
end

# # root (CRAN)
# if test -d ~/root/
#     fish_add_path ~/root/bin/ --path
# end

# ------------------------------
# Python
# ------------------------------

# disable venv prompt
set -gx VIRTUAL_ENV_DISABLE_PROMPT 1

# Conda
# if test -d ~/.anaconda3
#     set -gx PATH "/home/mike/.anaconda3/bin" $PATH
#     source (conda info --root)/etc/fish/conf.d/conda.fish
# end

# for pipenv on ubuntu
set -gx PATH "$HOME/.local/bin" $PATH

# # pyenv
# Pyenvが遅いので基本的にdeadsnakeを使う
set -gx PYENV_ROOT "$HOME/.pyenv"
set -gx PATH "$PYENV_ROOT/bin" $PATH
# pyenvは使う時だけ明示的にロードする
function use_pyenv
    status --is-interactive; and pyenv init --path | source
    status --is-interactive; and pyenv init - | source
end

# poetry
set POETRY_FOLDER $HOME/.poetry
if test -d "$POETRY_FOLDER"
    source $HOME/.poetry/env
end

# VENV
if set -q VIRTUAL_ENV
    echo 'reactivating virtualenv'
    source $VIRTUAL_ENV/bin/activate.fish
end

# ------------------------------
# Java
# ------------------------------

# JAVA
if type -q "java"
  set -gx JAVA_HOME $(readlink -f /usr/bin/javac | sed "s:/bin/javac::")
  set -gx PATH $JAVA_HOME/bin $PATH
end

# ------------------------------
# Ruby
# ------------------------------

# set -gx PATH $HOME/.rbenv/bin $PATH
# status --is-interactive; and rbenv init -| source

# ------------------------------
# Android
# ------------------------------

# Android
# export ANDROID_HOME=${HOME}/Android/Sdk
# export PATH=${PATH}:${ANDROID_HOME}/tools
# export PATH=${PATH}:${ANDROID_HOME}/platform-tools


# ------------------------------
# Go
# ------------------------------

# Golang
if type "go" > /dev/null
   set -gx GO111MODULE on
   set -gx GOPATH "$HOME/.go"
   set -gx PATH $GOPATH/bin $PATH
end


# ------------------------------
# GCP
# ------------------------------

# export CLOUDSDK_PYTHON=python2
#
# # The next line updates PATH for the Google Cloud SDK.
# if [ -f '/home/mike/google-cloud-sdk/path.zsh.inc' ]; then source '/home/mike/google-cloud-sdk/path.zsh.inc'; fi
#
# # The next line enables shell command completion for gcloud.
# if [ -f '/home/mike/google-cloud-sdk/completion.zsh.inc' ]; then source '/home/mike/google-cloud-sdk/completion.zsh.inc'; fi

# ------------------------------
# Perl
# ------------------------------

# # perl
# if type "perl" > /dev/null; then
#   PATH="/home/mike/perl5/bin${PATH:+:${PATH}}"; export PATH;
#   PERL5LIB="/home/mike/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
#   PERL_LOCAL_LIB_ROOT="/home/mike/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
#   PERL_MB_OPT="--install_base \"/home/mike/perl5\""; export PERL_MB_OPT;
#   PERL_MM_OPT="INSTALL_BASE=/home/mike/perl5"; export PERL_MM_OPT;
# fi

# ------------------------------
# Rust
# ------------------------------
set -gx PATH  ~/.cargo/bin/ $PATH

# ------------------------------
# Rustup
# ------------------------------
# source $HOME/.cargo/env
set -U fish_user_paths $fish_user_paths $HOME/.cargo/bin

# ------------------------------
# Home of Windows
# ------------------------------

set -gx WIN_HOME /mnt/c/Users/mike

# ------------------------------
# Code
# ------------------------------
set -gx PATH "/mnt/c/Program Files/Microsoft VS Code/bin" $PATH
set -gx PATH "/mnt/c/Users/mgold/AppData/Local/Programs/Microsoft VS Code/bin" $PATH

# ------------------------------
# Cmd and PowerShell
# ------------------------------
set -gx PATH "/mnt/c/Windows/System32" $PATH  # cmd.exe
set -gx PATH "/mnt/c/Windows/System32/WindowsPowerShell/v1.0" $PATH  # powershell


# ##########################
# NVM auto loading
# ##########################

# use fisher nvm plugin
# fisher install jorgebucaran/nvm.fish

# Automatically switch to the project's Node.js version
function nvm_auto_use -d "Automatically switch to the project's Node.js version"
  if test -e .nvmrc
    nvm use
  end
end

# Automatically run nvm_auto_use when changing directories
function cd -d 'Change directory with auto NVM version switch' --no-scope-shadowing --description 'Change directory with auto NVM version switch'
  builtin cd $argv
  nvm_auto_use
end

# ##########################
# Deno
# ##########################

set -gx DENO_INSTALL $HOME/.deno
set -gx PATH $DENO_INSTALL/bin $PATH

# ##########################
# Flutter
# ##########################

set -gx PATH $PATH $HOME/flutter/bin

# ##########################
# Snap
# ##########################
set -U fish_user_paths /snap/bin $fish_user_paths

