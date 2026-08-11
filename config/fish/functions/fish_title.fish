function fish_title
    # Inside zellij, show the (fixed) session name in the pane frame instead
    # of letting it track the current directory.
    if set -q ZELLIJ_SESSION_NAME
        echo $ZELLIJ_SESSION_NAME
        return
    end

    # Below is fish's stock fish_title (see /usr/share/fish/functions/fish_title.fish).
    if not set -q INSIDE_EMACS; or string match -vq '*,term:*' -- $INSIDE_EMACS
        set -l ssh
        set -q SSH_TTY
        and set ssh "["(prompt_hostname | string sub -l 10 | string collect)"]"
        if set -q argv[1]
            echo -- $ssh (string sub -l 20 -- $argv[1]) (prompt_pwd -d 1 -D 1)
        else
            set -l command (status current-command)
            if test "$command" = fish
                set command
            end
            echo -- $ssh (string sub -l 20 -- $command) (prompt_pwd -d 1 -D 1)
        end
    end
end
