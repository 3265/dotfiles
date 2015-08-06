# alias

alias l='ls -alhF --color=auto'


PS1="[\u@ \W]\[\033[36m\]\$(__git_ps1)\[\033[00m\]\$ "

#
# git-completion.bash / git-prompt.sh
#
if [ -f ~/myfile/git-completion.bash ]; then
    source ~/myfile/git-completion.bash
fi
if [ -f ~/myfile/git-prompt.sh ]; then
    source ~/myfile/git-prompt.sh
fi
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUPSTREAM=auto

# gitの設定

alias g-log='git log --graph --date=short --format="%C(yellow)%h%C(reset) %C(magenta)[%ad]%C(reset)%C(red)%d%C(reset) %s %C(cyan)@%an%C(reset)"'

#blog sshfs
alias blogfs='sshfs blog: ~/mp/blog -oauto_cache,reconnect,defer_permissions,negative_vncache,noappledouble,volname=blog'
alias kaishafs='sshfs kaisha: ~/mp/kaisha -oauto_cache,reconnect,defer_permissions,negative_vncache,noappledouble,volname=kaisha'
