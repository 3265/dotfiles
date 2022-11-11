function __fzf_autojump -d "auto jump"
    set -l commandline (__fzf_parse_commandline)
    set -l dir $commandline[1]
    set -l fzf_query $commandline[2]

    eval "autojump -s | sort -k1gr | awk '\$1 ~ /[0-9]:/ && \$2 ~ /^\// { for (i=2; i<=NF; i++) { print \$(i) } }' | fzf --prompt 'JumpToRecentDirectory>' --preview-window='bottom:3:wrap' --preview='echo {} | fish_indent --ansi' +m --query \"$fzf_query\"" | read -l select

    if not test -z "$select"
        builtin cd "$select"

        # Remove last token from commandline.
        commandline -t ""
    end

    commandline -f repaint
end
