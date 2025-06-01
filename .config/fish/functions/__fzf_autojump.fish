function __fzf_autojump -d "auto jump"
    # 今のプロンプト全体を取得
    set -l full_input (commandline)

    # 入力があればスキップ（何もせず終了）
    if test -n "$full_input"
        commandline -f repaint
        return
    end

    # autojump のパス一覧を fzf で選択
    set -l select (autojump -s | sort -k1gr \
        | awk '$1 ~ /[0-9]:/ && $2 ~ /^\// { for (i=2; i<=NF; i++) { print $(i) } }' \
        | fzf --prompt 'JumpToRecentDirectory>' \
              --preview-window='bottom:3:wrap' \
              --preview='echo {}' \
              +m)

    if test -n "$select"
        builtin cd "$select"
        commandline -t ""
    end

    commandline -f repaint
end

