# bashrc

# settings
export EDITOR=vim
export PAGER=less

# for virtual environment
export TERM=xterm

# shell option
shopt -s dotglob # Filter Hidden Files

# Golang
export GOPATH=$HOME/.go
export PATH=$PATH:$GOROOT:$GOPATH:$GOPATH/bin

# Node.js
export NODE_ENV=development
export NODE_PATH=~/.nvm/versions/node/v0.12.0/lib/node_modules/

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

# sortcuts
alias a='ag'
alias b='cd ../'
alias c='cd'
alias d='docker'
alias e='grep --color=auto'
alias f='coffee'
alias g='git'
alias h='chown'
alias i="dig +short myip.opendns.com @resolver1.opendns.com"
alias j='jq'
alias k='mkdir' # -p
alias l='ls-color'
alias m='mv'
alias n='node'
alias o='go'
alias p='pwd'
alias q='exit'
alias r='rustc'
alias s='screen'
alias t='mocha --compilers js:babel/register'
alias u='curl'
alias v='vim'
alias w='w'
alias x='cacaview'
alias y='cp'
alias z='nmap'

# user
alias u-list='getent passwd'
alias u-add='adduser'
alias u-delete='userdel'
alias u-passwd='passwd'

# computer info
alias i-host='hostname'
alias i-top='htop'
alias i-cpu='cat /proc/cpuinfo'
alias i-partition='df -Th'
alias i-memory='free -m'
# alias i-ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias i-localip="ipconfig getifaddr en1"
alias i-port='netstat -atn'
alias i-getway='route'
alias i-dist='lsb_release -a'
alias i-arch='uname -a'
alias i-stat='git ls-files | xargs wc -l'

# mac sshfs
alias blogfs='sshfs blog: ~/mp/blog -oauto_cache,reconnect,defer_permissions,negative_vncache,noappledouble,volname=blog'
alias kaishafs='sshfs kaisha: ~/mp/kaisha -oauto_cache,reconnect,defer_permissions,negative_vncache,noappledouble,volname=kaisha'

# bash-completion for g alias
complete -o bashdefault -o default -o nospace -F _git g 2>/dev/null \
    || complete -o default -o nospace -F _git g

