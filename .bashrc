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

# alias
alias a='ag'
alias c='cd'
alias l='ls-color'
alias d='df -Th'
alias g=git
alias h='source-hilight-less'
alias m='chmod'
alias o='chown'
alias p='cp'
alias s='source'
alias u='umount'
alias f='free -m'
alias v='vim'
alias w='w'

# user
alias u-list='getent passwd'
alias u-add='adduser'
alias u-delete='userdel'
alias u-passwd='passwd'

## computer info
alias i-host='hostname'
alias i-cpu='cat /proc/cpuinfo'
alias i-partition='df -h'
alias i-memory='free -m'
alias i-ip='ifconfig eth0'
alias i-port='netstat -atn'
alias i-getway='route'
alias i-dist='lsb_release -a'
alias i-arch='uname -a'

## ssh
alias blogfs='sshfs blog: ~/mp/blog -oauto_cache,reconnect,defer_permissions,negative_vncache,noappledouble,volname=blog'
alias kaishafs='sshfs kaisha: ~/mp/kaisha -oauto_cache,reconnect,defer_permissions,negative_vncache,noappledouble,volname=kaisha'

##autoscreen
source ~/dotfiles/sh/autoscreen.sh
