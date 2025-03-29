function __fzf_open -d "Open files only with fzf"
    # 現在の入力文字列
    set -l current_input (commandline -t)
    set -l full_input (commandline)

    # 検索対象のディレクトリ
    set -l dir "."

    # fzfの初期検索クエリ（入力されていたら使う）
    set -l fzf_query ""
    if test -n "$current_input"
        set fzf_query "$current_input"
    end

    # fzf を使ってファイルを選択
    set -l raw_select (command find -L $dir -type f -print 2> /dev/null \
        | fzf --prompt='FindFile>' \
              --preview-window='bottom:3:wrap' \
              --preview='echo {}' \
              -m --query "$fzf_query")

    # 空でなければ escape
    set -l select (string escape $raw_select)

    set -l open_status 0
    if test -n "$select"
        if test -n "$full_input"
            # 何か入力中（catなど）→ 選択ファイルを貼り付け
            commandline -t ""
            commandline -it "$select "
        else
            # 何も入力していない → エディタで開く
            commandline "$EDITOR $select"
            commandline -f execute
            set open_status $status
        end
    end

    commandline -f repaint
    return $open_status
end

