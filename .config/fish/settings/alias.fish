#!/bin/fish

# Command shortcut
alias a="ag --hidden --ignore .git"
alias c='cling'
alias d='docker'
alias dc="docker-compose"
alias p='python3'
alias g='git'
alias l='runls'
alias s='screen'
alias v='vim'

# quick directory transition
alias nd='nextd'
alias pd='prevd'

# i brothers
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

function runls
  if type -q "lsd"
      lsd -la --group-dirs=first $argv
   else
      LC_COLLATE=C ls -al --color=auto --human-readable --group-directories-first $argv
  end
end

# Util
alias cat='bat --style=plain'
alias bat='/usr/bin/batcat'
alias free='free -h'
alias rename='mv'
alias fastreset="echo -ne \\\0033\\\0143" # echo -ne '\0033\0143'
alias se='sudoedit'
alias ssh-igk='ssh -oUserKnownHostsFile=/dev/null -oStrictHostKeyChecking=no'
alias open='xdg-open'
alias cr='cd $(ghq list -p | fzf --reverse)'

# permission
alias 644='sudo chmod 644'
alias 755='sudo chmod 755'
alias 777='sudo chmod 777'

# typo
alias gl='g l'
alias gs='g s'
alias gd='g d'
alias ll='l'

# Color
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias less='less -R'
alias gitwatch='fswatch -0 . | xargs -0 -n 1 sh -c "clear && git status --short"' # to need to install fswatch

# Others

# Shell
alias bsh='bash'
alias zsh='zsh'
alias msh='mosh'
alias psh='parallel-ssh'
alias tsh='tasksh' # for task
alias vsh='virsh' # KVM

# win
alias win-open='wslview .'
alias win-path='command wslpath -w .'

# Others
alias zen='python -m this'
alias py='python'
alias py3='python3'
alias gpg_off='git config commit.gpgsign false'
alias copy='echo $PWD | xsel -b'
alias clone="python3 ~/dotfiles/scripts/clone.py $argv"
alias music='vimpc'
alias reboot='reboot'
alias shutdown='shutdown -h now'
alias suspend='systemctl suspend'
alias search='chromium-browser --app="https://google.com/"' # search

