# git-completion.bash / git-prompt.sh
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
alias c='cp'
alias l='ls -alhF --color=auto'
alias d='df -Th'
alias g=git
alias s='sudo'
alias h='source-hilight-less'
alias s='source'
alias r='route'
alias f='free -m'
alias w='w'

alias ul='getent passwd'
alias ua='adduser'
alias ud='userdel'
alias up='passwd'
alias ch='chmod'
alias co='chown'

alias blogfs='sshfs blog: ~/mp/blog -oauto_cache,reconnect,defer_permissions,negative_vncache,noappledouble,volname=blog'
alias kaishafs='sshfs kaisha: ~/mp/kaisha -oauto_cache,reconnect,defer_permissions,negative_vncache,noappledouble,volname=kaisha'
