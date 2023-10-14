#!/bin/fish

# Command shortcut
alias ai="chatgpt --model=gpt4"
alias a="ag --hidden --ignore .git"
alias c="curl"
alias d='docker'
alias dc="docker-compose"
alias e='/mnt/c/Windows/explorer.exe'
function searchfile
    find . -not -path './node_modules*' \
        -a -not -path '*.git*' \
        -iname "*"$argv"*"
end
alias f=searchfile
alias h='history'
alias p='python' # install python-is-python3
alias g='git'
alias k='make'
alias l='runls'
alias reload='source ~/.config/fish/config.fish'
alias r=reload
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
alias sys='systemctl'
alias jou='jounalctl'

function runls
  if type -q "lsd"
      lsd -la --group-dirs=first $argv
   else
      LC_COLLATE=C ls -al --color=auto --human-readable --group-directories-first $argv
  end
end

function joshuto_cd
    joshuto --output-file /tmp/joshutodir
    set LASTDIR (cat /tmp/joshutodir)
    cd "$LASTDIR"
    commandline -f repaint
    clear
end

function runi
    set _branch $(git symbolic-ref --short HEAD 2> /dev/null)
    set _stash_list $(git stash list 2> /dev/null | wc -l)
    set _untracked $(git ls-files --others --exclude-standard 2> /dev/null | wc -l)
    set _modified $(git status   2> /dev/null | grep 'modified:' | wc -l)
    set _head $(git rev-parse --short HEAD 2> /dev/null)
    set _last_message $(git show -s --format=%s 2> /dev/null)
    set _commit_date $(git log -1 --format='%cd' 2> /dev/null)
    set _acs $(stat -c '%a (%A)' .)
    set _uid $(stat -c '%U (%u)' .)
    set _gid $(stat -c '%G (%g)' .)

    echo "- Machine:
  - Username: $(whoami)
  - Hostname: $(hostname)
- File:
  - Path : $(pwd)
  - Access: $_acs
  - Uid: $_uid
  - Gid: $_gid
- Commit:
  - Hash: $_head
  - Date: $_commit_date
  - Message: $_last_message
  - Branch: $_branch
- Status:
  - Modified : $_modified
  - Untracked: $_untracked
  - Stashed: $_stash_list
- Venv:
  - .venv: $(echo $VIRTUAL_ENV)"
end

function runpath
    echo "- Path
  - C: $(which c)
  - C++: $(which c++)
  - Python: $(which python)
  - Go: $(which go)
  - Java: $(which java)
  - Node: $(which node)"
end

function ranger_cd
    set -l tempfile (mktemp)
    set -q argv[1]; and set dir_initial $argv[1]; or set dir_initial (pwd)
    ranger --choosedir="$tempfile" "$dir_initial"
    if test -f "$tempfile"
        set -l dir (cat "$tempfile")
        rm -f "$tempfile"
        cd -- "$dir"
        commandline -f repaint
    end
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

# Others

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

