function __fzf_cd -d "Change directory or paste path"
    # 現在のプロンプトの状態を取得
    set -l full_input (commandline)
    set -l current_token (commandline -t)

    set -l fzf_query ""
    if test -n "$current_token"
        set fzf_query "$current_token"
    end

    # ディレクトリ一覧を検索対象（.git, /dev, /proc 除外）
    set -l select (command find -L . \
        \( -path '*/.git*' -o -fstype 'dev' -o -fstype 'proc' \) -prune \
        -o -type d -print 2> /dev/null \
        | sed 1d | cut -b3- \
        | fzf --prompt 'FindDirectory>' \
              --preview-window='bottom:3:wrap' \
              --preview='tree -L 1 {} | head -n 20' \
              +m --query "$fzf_query")

    if test -n "$select"
        if test -n "$full_input"
            # すでに何か入力中 → パスとして貼り付け
            commandline -t ""
            commandline -it -- (string escape -- "$select/")
        else
            # 入力が空 → cd 実行
            builtin cd "$select"
        end
    end

    commandline -f repaint
end

