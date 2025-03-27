function __fzf_cd -d "Change directory or paste path"
    # 現在のコマンドラインの状態を取得
    set -l commandline (__fzf_parse_commandline)
    set -l dir $commandline[1]
    set -l fzf_query $commandline[2]

    set -l full_input (commandline)

    set -q COMMAND
    or set -l COMMAND "
    command find -L \$dir \
    \\( -path '*/\\.git*' -o -fstype 'dev' -o -fstype 'proc' \\) -prune \
    -o -type d -print 2> /dev/null | sed 1d | cut -b3-"

    # fzfでディレクトリ選択
    eval "$COMMAND | fzf --prompt 'ChangeDirectory>' --preview-window='bottom:3:wrap' --preview='echo {}' +m --query \"$fzf_query\"" | read -l select

    if not test -z "$select"
        if test -n "$full_input"
            # すでに入力がある → パスとして貼り付ける
            commandline -t ""
            commandline -it -- (string escape -- "$select/")
        else
            # 入力がない → cd する
            builtin cd "$select"
        end
    end

    commandline -f repaint
end

