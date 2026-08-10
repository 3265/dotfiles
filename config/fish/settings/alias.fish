#!/bin/fish

# Command shortcut
alias a="alias"
alias b='bc -l'
alias c="/usr/bin/batcat --style=plain" # cat
alias d='docker'
alias dc="docker compose"
alias docker-compose="docker compose"
alias e='explorer'
alias f="ag --hidden --ignore .git"
alias f-count=count_files
alias f-stats=extension_stats
alias h='history'
alias g='git'
alias gf='git fetch'
alias i=ai
alias k='kill'
alias l='runls'
alias m='make'
alias n='nvim'
alias p='autojump --purge'
alias q='kiro-cli'
alias reload='source ~/.config/fish/config.fish'
alias r='readlink -f'
alias s='screen -t home -U'
alias v='vim'
alias claude-personal='env CLAUDE_CONFIG_DIR=$HOME/.claude-personal claude'
alias claude-work='env CLAUDE_CONFIG_DIR=$HOME/.claude-work claude'
alias x='tmux'
function _ai_free_port -a base
    set -l port $base
    while ss -ltn 2>/dev/null | string match -q "*:$port *"
        set port (math $port + 1)
    end
    echo $port
end

function ai -d "Launch AI assistant"
    set choice (printf "claude-personal\nclaude-work\ngemini\ncodex\nantigravity" | fzf --reverse --prompt="AI> " --height=~10)
    switch $choice
        case "claude-personal"
            claude-personal --dangerously-skip-permissions $argv
        case "claude-work"
            claude-work --dangerously-skip-permissions $argv
        case "gemini"
            gemini --yolo $argv
        case "codex"
            codex --yolo $argv
        case "antigravity"
            agy --dangerously-skip-permissions $argv
    end
end

function tops -d "Launch a system monitor"
    set choice (printf "btop\nhtop\nnvtop\ntop" | fzf --reverse --prompt="Monitor> " --height=~10)
    switch $choice
        case "btop"
            btop
        case "htop"
            htop
        case "nvtop"
            nvtop
        case "top"
            top
    end
end

function _t_create -d "Create a tmux session and expose it over ttyd (runs in the background)"
    set -l port (_ai_free_port 7000)
    set -l n (math $port - 7000 + 1)
    set -l title
    read -P "session title (empty = ttyd-$n): " title
    if test -z "$title"
        set title ttyd-$n
    end
    set -l page (bash ~/dotfiles/config/ttyd/build.sh)
    or return 1
    if not tmux has-session -t $title 2>/dev/null
        tmux new-session -d -s $title
    end
    sudo ufw allow $port
    set -l ip (hostname -I | awk '{print $1}')
    mkdir -p ~/.cache/ttyd
    set -l log ~/.cache/ttyd/$title.log
    nohup ttyd -W -i 0.0.0.0 -p $port -t titleFixed=$title -I $page tmux new-session -A -s $title >$log 2>&1 &
    disown
    echo "tmux session: $title"
    echo "URL: http://$ip:$port"
    echo "pid: $last_pid  log: $log"
end

function _t_ttyd_info -a name -d "Print 'pid port' of the ttyd process serving tmux session $name, if any"
    ps -eo pid=,args= | while read -l pid args
        if string match -q '*ttyd *' -- $args; and string match -qr -- "-s $name\$" $args
            set -l m (string match -r -- '-p\s+(\S+)' $args)
            echo "$pid $m[2]"
        end
    end
end

function _t_session_choices -d "Table of tmux sessions (NAME WIN STATE TTYD LAST-USED CREATED), header on line 1, for fzf --header-lines=1"
    set -l tab \t
    set -l rows "NAME"$tab"WIN"$tab"STATE"$tab"TTYD"$tab"LAST USED"$tab"CREATED"
    for line in (tmux list-sessions -F "#{session_name}$tab#{session_windows}$tab#{?session_attached,attached,detached}$tab#{t:session_activity}$tab#{t:session_created}" 2>/dev/null)
        set -l f (string split \t -- $line)
        set -l name $f[1]
        set -l ttyd_str "-"
        set -l ttyd_info (_t_ttyd_info $name)
        if test -n "$ttyd_info"
            set -l port (string split ' ' -- $ttyd_info)[2]
            set ttyd_str "ttyd:$port"
        end
        set -a rows "$name$tab$f[2]w$tab$f[3]$tab$ttyd_str$tab$f[4]$tab$f[5]"
    end
    if test (count $rows) -le 1
        return
    end
    printf '%s\n' $rows | column -t -s \t
end

function _t_list -d "List tmux/ttyd sessions (non-interactive)"
    set -l choices (_t_session_choices)
    if test -z "$choices"
        echo "no tmux sessions"
        return 1
    end
    printf '%s\n' $choices
end

function _t_attach -d "Attach to an existing tmux session (never nested)"
    set -l choices (_t_session_choices)
    if test -z "$choices"
        echo "no tmux sessions"
        return 1
    end
    set -l picked (printf '%s\n' $choices | fzf --reverse --header-lines=1 --prompt="attach> " --height=~12)
    if test -z "$picked"
        return 1
    end
    set -l name (string split -f1 -- ' ' $picked)
    env -u TMUX tmux attach -t "$name"
end

function _t_delete -d "Delete a tmux session (and its ttyd server, if any)"
    set -l choices (_t_session_choices)
    if test -z "$choices"
        echo "no tmux sessions"
        return 1
    end
    set -l picked (printf '%s\n' $choices | fzf --reverse --header-lines=1 --prompt="delete> " --height=~12)
    if test -z "$picked"
        return 1
    end
    set -l name (string split -f1 -- ' ' $picked)
    read -P "delete session '$name'? [y/N] " -l confirm
    if test "$confirm" != y -a "$confirm" != Y
        echo cancelled
        return 1
    end
    for info in (_t_ttyd_info $name)
        set -l parts (string split ' ' $info)
        echo "stopping ttyd (pid $parts[1], port $parts[2])"
        kill $parts[1]
        sudo ufw delete allow $parts[2]
    end
    tmux kill-session -t "$name"
    echo "deleted session: $name"
end

function t_func -d "Manage tmux/ttyd sessions"
    set -l choice $argv[1]
    if test -z "$choice"
        set choice (printf "create\nattach\ndelete\nlist" | fzf --reverse --prompt="t> " --height=~10)
        if test -z "$choice"
            echo "cancelled"
            return 1
        end
    end
    switch $choice
        case create
            _t_create
        case attach
            _t_attach
        case delete
            _t_delete
        case list
            _t_list
        case '*'
            echo "usage: t [create|attach|delete|list]"
            return 1
    end
end
alias t=t_func
alias y='yes'
alias gap='~/gap/build/gap'

# copy
alias co='xclip -selection clipboard <'
alias screen-copy='scrcpy'

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
alias pm='uv' # python manamger
alias pa='source .venv/bin/activate.fish' # python activation
alias py-init="uv init && uv venv && gibo dump Python >> .gitignore"

# makefile
alias m1='make 1'
alias m2='make 2'
alias m3='make 3'
alias m4='make 4'
alias m5='make 5'
alias m6='make 6'

# Util
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

# GUI
alias kde-restart='killall plsmashell && kstart5 plasmashell'
alias kde-reset='qdbus org.kde.KWin /Compositor resume'

# AI
alias cl="claude --dangerously-skip-permissions"
alias gm="gemini --yolo"
alias cx="codex --yolo"
alias ay="agy --dangerously-skip-permissions"

# wifi
function wifi
    sudo systemctl restart NetworkManager
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
