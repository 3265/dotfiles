function __fzf_cd -d "Change directory"
    set -l commandline (__fzf_parse_commandline)
    set -l dir $commandline[1]
    set -l fzf_query $commandline[2]

    set -q COMMAND
    or set -l COMMAND "
    command find -L \$dir \
    \\( -path '*/\\.git*' -o -fstype 'dev' -o -fstype 'proc' \\) -prune \
    -o -type d -print 2> /dev/null | sed 1d | cut -b3-"

    # eval "$COMMAND | fzf +m $FZF_CD_OPTS --query \"$fzf_query\"" | read -l select
    eval "$COMMAND | fzf --prompt 'ChangeDirctory>' --preview-window='bottom:3:wrap' --preview='echo {} | fish_indent --ansi' +m --query \"$fzf_query\"" | read -l select

    if not test -z "$select"
        builtin cd "$select"

        # Remove last token from commandline.
        commandline -t ""
    end

    commandline -f repaint
end
