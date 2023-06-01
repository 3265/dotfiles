function __fzf_find_file -d "List files and folders"
    set -l commandline (__fzf_parse_commandline)
    set -l dir $commandline[1]
    set -l fzf_query $commandline[2]

    set -q FZF_FIND_FILE_COMMAND
    or set -l FZF_FIND_FILE_COMMAND "
    command find -L \$dir \
    -type f -print \
    -type d -print \
    -type l -print 2> /dev/null"

    begin
        eval "$FZF_FIND_FILE_COMMAND | fzf -m --prompt=\"CopyFilePath>\" --preview-window=\"bottom:3:wrap\" --preview=\"echo {}\" --query \"$fzf_query\""  | while read -l s; set results $results $s; end
    end

    if test -z "$results"
        commandline -f repaint
        return
    else
        commandline -t ""
    end

    for result in $results
        commandline -it -- (string escape $result)
        commandline -it -- " "
    end
    commandline -f repaint
end
