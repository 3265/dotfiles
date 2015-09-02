# settings
export EDITOR=vim
export PAGER=less
HISTSIZE=10000
HISTFILESIZE=10000

# git
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

# alias
alias a='ag'
alias c='cd'
alias d='df -Th'
alias e='grep -r -E --color'
alias l='ls-color'
alias g='git'
alias h='source-hilight-less'
alias i='id'
alias m='chmod'
alias o='chown'
alias p='peco'
alias s='screen'
alias u='umount'
alias f='free -m'
alias v='vim'
alias w='w'

# user
alias u-list='getent passwd'
alias u-add='adduser'
alias u-delete='userdel'
alias u-passwd='passwd'

# computer info
alias i-host='hostname'
alias i-cpu='cat /proc/cpuinfo'
alias i-partition='df -h'
alias i-memory='free -m'
alias i-ip='curl ifconfig.me'
alias i-port='netstat -atn'
alias i-getway='route'
alias i-dist='lsb_release -a'
alias i-arch='uname -a'

# ssh
alias blogfs='sshfs blog: ~/mp/blog -oauto_cache,reconnect,defer_permissions,negative_vncache,noappledouble,volname=blog'
alias kaishafs='sshfs kaisha: ~/mp/kaisha -oauto_cache,reconnect,defer_permissions,negative_vncache,noappledouble,volname=kaisha'

# bash-completion for g alias
complete -o bashdefault -o default -o nospace -F _git g 2>/dev/null \
    || complete -o default -o nospace -F _git g

##autoscreen
#source ~/dotfiles/sh/autoscreen.sh
