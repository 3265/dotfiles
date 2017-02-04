# shell option
shopt -s dotglob # Filter Hidden Files

# Git template directory
# export GIT_TEMPLATE_DIR=$HOME/.git_template

# Python
#export PATH="~/.pyenv/bin:$PATH"

HISTSIZE=10000
HISTFILESIZE=10000

# git completion
PS1="[\u@ \W]\[\033[36m\]\$(__git_ps1)\[\033[00m\]\$ "
if [ -f ~/dotfiles/sh/git-completion.bash ]; then
    source ~/dotfiles/sh/git-completion.bash
fi
if [ -f ~/dotfiles/sh/git-prompt.sh ]; then
    source ~/dotfiles/sh/git-prompt.sh
fi
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUPSTREAM=auto


# nvm
if [[ -s ~/.nvm/nvm.sh ]];
  then source ~/.nvm/nvm.sh
fi

# Reload command aliases
source ~/dotfiles/.export

# Reload command aliases
source ~/dotfiles/.aliases

# mac sshfs
# alias blogfs='sshfs blog: ~/mp/blog -oauto_cache,reconnect,defer_permissions,negative_vncache,noappledouble,volname=blog'
# alias kaishafs='sshfs kaisha: ~/mp/kaisha -oauto_cache,reconnect,defer_permissions,negative_vncache,noappledouble,volname=kaisha'

# bash-completion for g alias
complete -o bashdefault -o default -o nospace -F _git g 2>/dev/null \
    || complete -o default -o nospace -F _git g

