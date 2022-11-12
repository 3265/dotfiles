function __fzf_open -d "Open files and directories."
    set -l commandline (__fzf_parse_commandline)
    set -l dir $commandline[1]
    set -l fzf_query $commandline[2]

    set -q FZF_OPEN_COMMAND
    or set -l FZF_OPEN_COMMAND "
    command find -L \$dir \
    -type f -print \
    -type d -print \
    -type l -print 2> /dev/null "

    set -l select (eval "$FZF_OPEN_COMMAND | fzf --prompt 'OpenFile>' --preview-window='bottom:3:wrap' --preview='echo {} | fish_indent --ansi' -m --query \"$fzf_query\"" | string escape)

    set -l open_status 0
    if not test -z "$select"
        commandline "$EDITOR $select"; and commandline -f execute
        set open_status $status
    end

    commandline -f repaint
    return $open_status
end
