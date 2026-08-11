function _z_free_port -a base
    set -l port $base
    while ss -ltn 2>/dev/null | string match -q "*:$port *"
        set port (math $port + 1)
    end
    echo $port
end

function _z_create -d "Create a zellij session and expose it over ttyd (runs in the background)"
    set -l port (_z_free_port 7000)
    set -l n (math $port - 7000 + 1)
    set -l title
    read -P "session title (empty = ttyd-$n): " title
    if test -z "$title"
        set title ttyd-$n
    end
    set -l page (bash ~/dotfiles/config/ttyd/build.sh)
    or return 1
    if not contains -- $title (zellij list-sessions -s 2>/dev/null)
        zellij attach --create-background $title
    end
    sudo ufw allow $port
    set -l ip (hostname -I | awk '{print $1}')
    mkdir -p ~/.cache/ttyd
    set -l log ~/.cache/ttyd/$title.log
    nohup ttyd -W -i 0.0.0.0 -p $port -t titleFixed=$title -I $page zellij attach --create $title >$log 2>&1 &
    disown
    echo "zellij session: $title"
    echo "URL: http://$ip:$port"
    echo "pid: $last_pid  log: $log"
end

function _z_ttyd_info -a name -d "Print 'pid port' of the ttyd process serving zellij session $name, if any"
    ps -eo pid=,args= | while read -l pid args
        if string match -q '*ttyd *' -- $args; and string match -q -- "*zellij attach --create $name" $args
            set -l m (string match -r -- '-p\s+(\S+)' $args)
            echo "$pid $m[2]"
        end
    end
end

function _z_session_choices -d "Table of zellij sessions (NAME TABS TTYD CREATED), header on line 1, for fzf --header-lines=1"
    set -l tab \t
    set -l rows "NAME"$tab"TABS"$tab"TTYD"$tab"CREATED"
    for line in (zellij list-sessions -n 2>/dev/null)
        set -l m (string match -r -- '^(\S+) \[Created ([^\]]+)\]' $line)
        if test -z "$m"
            continue
        end
        set -l name $m[2]
        set -l created $m[3]
        set -l tabs (zellij -s $name action list-tabs 2>/dev/null | count)
        set tabs (math $tabs - 1)
        if test $tabs -lt 0
            set tabs 0
        end
        set -l ttyd_str "-"
        set -l ttyd_info (_z_ttyd_info $name)
        if test -n "$ttyd_info"
            set -l port (string split ' ' -- $ttyd_info)[2]
            set ttyd_str "ttyd:$port"
        end
        set -a rows "$name$tab$tabs"w"$tab$ttyd_str$tab$created"
    end
    if test (count $rows) -le 1
        return
    end
    printf '%s\n' $rows | column -t -s \t
end

function _z_list -d "List zellij/ttyd sessions (non-interactive)"
    set -l choices (_z_session_choices)
    if test -z "$choices"
        echo "no zellij sessions"
        return 1
    end
    printf '%s\n' $choices
end

function _z_attach -d "Attach to an existing zellij session (never nested)"
    set -l choices (_z_session_choices)
    if test -z "$choices"
        echo "no zellij sessions"
        return 1
    end
    set -l picked (printf '%s\n' $choices | fzf --reverse --header-lines=1 --prompt="attach session> " --height=~12)
    if test -z "$picked"
        return 1
    end
    set -l session (string split -f1 -- ' ' $picked)
    env -u ZELLIJ zellij attach "$session"
end

function _z_delete -d "Delete a zellij session (and its ttyd server, if any)"
    set -l choices (_z_session_choices)
    if test -z "$choices"
        echo "no zellij sessions"
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
    for info in (_z_ttyd_info $name)
        set -l parts (string split ' ' $info)
        echo "stopping ttyd (pid $parts[1], port $parts[2])"
        kill $parts[1]
        sudo ufw delete allow $parts[2]
    end
    zellij delete-session "$name" --force
    echo "deleted session: $name"
end

function z_cmd -d "Manage zellij/ttyd sessions"
    set -l choice $argv[1]
    if test -z "$choice"
        set choice (printf "create\nattach\ndelete\nlist" | fzf --reverse --prompt="z> " --height=~10)
        if test -z "$choice"
            echo "cancelled"
            return 1
        end
    end
    switch $choice
        case create
            _z_create
        case attach
            _z_attach
        case delete
            _z_delete
        case list
            _z_list
        case '*'
            echo "usage: z [create|attach|delete|list]"
            return 1
    end
end
