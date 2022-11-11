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
set PATH $PATH "$HOME/bin"

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

# for VCPKG
if test -d ~/vcpkg/
    set PATH $PATH ~/vcpkg/
end

# ------------------------------
# Java
# ------------------------------

# JAVA
if type -q "java"
  set JAVA_HOME $(readlink -f /usr/bin/javac | sed "s:/bin/javac::")
  set PATT $PATH $JAVA_HOME/bin
end

# ------------------------------
# Ruby
# ------------------------------

# # Ruby Env
# if type "rbenv" > /dev/null; then
#   export PATH="$HOME/.rbenv/bin:$PATH"
#   eval "$(rbenv init -)"
# fi

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
  set GOPATH $HOME/.go
  set PATH $PATH $GOROOT $GOPATH $GOPATH/bin
end


# ------------------------------
# Anyenv
# ------------------------------

# Anyenv
# if [ -d ${HOME}/.anyenv ] ; then
#   export PATH="$HOME/.anyenv/bin:$PATH"
#   eval "$(anyenv init -)"
# fi
#

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

# Rust
set PATH $PATH ~/.cargo/bin/

# ------------------------------
# Node
# ------------------------------

# NVM
# export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# ------------------------------
# Root
# ------------------------------

# root (CRAN)
if test -d ~/root/
    set PATH $PATH "~/root/bin"
end


# ------------------------------
# Python
# ------------------------------

# Anaconda3
set PATH "/home/mike/anaconda3/bin" $PATH

# pyenv
set PYENV_ROOT "$HOME/.pyenv"
set PATH $PATH "$PYENV_ROOT/bin"
eval "$(pyenv init --path)"

# for pipenv on ubuntu
set PATH $PATH "$HOME/.local/bin"

# poetry
set POETRY_FOLDER $HOME/.poetry
if test -d "$POETRY_FOLDER"
    source $HOME/.poetry/env
end
