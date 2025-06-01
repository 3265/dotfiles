function __fzf_autojump -d "auto jump"
    # 今のプロンプト全体を取得
    set -l full_input (commandline)

    # 入力があればスキップ（何もせず終了）
    if test -n "$full_input"
        commandline -f repaint
        return
    end

    # autojump のパス一覧を fzf で選択
    # 古いパスはCtrl-Dで消す
    set -l select (autojump -s | sort -k1gr \
        | awk '$1 ~ /[0-9]:/ && $2 ~ /^\// { for (i=2; i<=NF; i++) { print $(i) } }' \
        | fzf --prompt 'JumpToRecentDirectory>' \
              --preview-window='bottom:3:wrap' \
              --preview='echo {}' \
              --bind 'ctrl-d:execute(autojump --purge && echo "[autojump] Purged nonexistent paths." >&2)' \
              --expect=enter \
              +m)

    if test (count $select) -gt 1
        set -l key $select[1]
        set -l path $select[2]

        if test "$key" = enter -a -d "$path"
            builtin cd "$path"
            commandline -t ""
        end
    end

    commandline -f repaint
end

