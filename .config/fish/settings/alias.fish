#!/bin/fish

# Command shortcut
alias a="ag --hidden --ignore .git"
alias b="bash"
alias c="code"
alias d='docker'
alias dc="docker-compose"
alias e='/mnt/c/Windows/explorer.exe'
alias f=search_file
alias f-count=count_files
alias f-stats=extension_stats
alias h='history'
alias p='python'
alias g='git'
alias i=runi
alias k='kill'
alias l='runls'
alias m='make'
alias reload='source ~/.config/fish/config.fish'
alias r='glow' # for README.md
alias s='screen -t pj'
alias t='touch'
alias v='vim'

# quick directory transition
alias nd='nextd'
alias pd='prevd'

# i brothers
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# systemd
alias systemctrl='systemctl'
alias journalctrl='jounalctl'
alias sys='systemctl'
alias jou='jounalctl'

# python
alias py='python' # install python-is-python3
alias pe='pyenv' # python environment
alias pm='poetry' # python manamger
alias pa='source .venv/bin/activate.fish'

# makefile
alias m1='make 1'
alias m2='make 2'
alias m3='make 3'
alias m4='make 4'
alias m5='make 5'
alias m6='make 6'

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
alias clang-format='clang-format-14'

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

# Shell
alias bsh='bash'
alias fsh='fish'
alias zsh='zsh'
alias msh='mosh'
alias psh='parallel-ssh'
alias tsh='tasksh' # for task
alias vsh='virsh' # KVM

# win
alias win-open='wslview .'
alias win-path='command wslpath -w .'

function cdw
  set wsl_path (wslpath $argv[1])
  cd $wsl_path
end

# Others
alias zen='python3 -m this'
alias py='python'
alias py3='python3'
alias gpg_off='git config commit.gpgsign false'
alias copy='echo $PWD | xsel -b'
alias clone="python3 ~/dotfiles/scripts/clone.py $argv"
alias music='vimpc'
alias reboot='reboot'
alias shutdown='shutdown -h now'
alias suspend='systemctl suspend'
alias search='chromium-browser --app="https://google.com/"'

# my funcitons
function runls
  if type -q "lsd"
      lsd -la --group-dirs=first $argv
   else
      LC_COLLATE=C ls -al --color=auto --human-readable --group-directories-first $argv
  end
end

# find
function search_file
    set name $argv
    find . -not -path './node_modules*' -a -not -path '*.git*' -iname "*$name*"
end

function count_files
    set dir $argv[1]
    find $dir -type d \( -name node_modules -o -name .git \) -prune -o -type f -print | wc -l
end

function extension_stats
    set dir $argv[1]
    find $dir -type f | awk -F. '{if (NF>1) print $NF}' | sort | uniq -c | sort -nr
end

function codemod
  set target_name $argv[1]
  set new_name $argv[2]

  if test -z "$target_name" -o -z "$new_name"
    echo "Both target_name and new_name are required."
    return 1
  end

  fastmod -m --extensions yaml,ts,tsx,yaml,yml,json,toml,js,py,css,Dockerfile,env,md,html,conf,template,properties,dart $target_name $new_name
end


function remove_zone
    find . -name "*:Zone.Identifier" -type f -delete
end
