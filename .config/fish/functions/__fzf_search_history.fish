function __fzf_search_history --description "Search command history. Replace the command line with the selected command."
    # Delinate commands throughout pipeline using null rather than newlines because commands can be multi-line
    set commands_selected (
        # Reference https://devhints.io/strftime to understand strftime format symbols
        builtin history --null |
        fzf --read0 \
            --print0 \
            --multi \
            --prompt 'SearchHstory>' \
            --tiebreak=index \
            --query=(commandline) \
            --preview="echo {}" \
            --preview-window="bottom:3:wrap" \
            $fzf_history_opts |
        string split0
    )

    if test $status -eq 0
        commandline --replace -- $commands_selected
    end

    commandline --function repaint
end

