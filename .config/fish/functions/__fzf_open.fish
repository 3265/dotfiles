function __fzf_open -d "Open files and directories."
    set -l commandline (__fzf_parse_commandline)
    set -l dir $commandline[1]
    set -l fzf_query $commandline[2]

    set -q FZF_OPEN_COMMAND
    or set -l FZF_OPEN_COMMAND "
    command find -L \$dir -mindepth 1 \\( -path \$dir'*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' \\) -prune \
    -o -type f -print \
    -o -type d -print \
    -o -type l -print 2> /dev/null | sed 's@^\./@@'"

    set -l select (eval "$FZF_OPEN_COMMAND | fzf --prompt 'File>' -m --query \"$fzf_query\"" | string escape)

    set -l open_status 0
    if not test -z "$select"
        commandline "$EDITOR $select"; and commandline -f execute
        set open_status $status
    end

    commandline -f repaint
    return $open_status
end
