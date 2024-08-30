set -g fish_prompt_pwd_dir_length 4

function fish_prompt
    echo -n '▶ '
end 

# トップライン表示を制御する環境変数
set -g SHOW_TOP_LINE 1

# function fish_right_prompt
#     prompt_pwd
# end

function fish_update_top_line --on-variable PWD --on-variable fish_bind_mode --on-event fish_postexec
    if test "$SHOW_TOP_LINE" = "0"
        return
    end

    # git info
    set -l git_branch (git rev-parse --abbrev-ref HEAD 2>/dev/null)
    set -l git_info ""
    if test -n "$git_branch"
        set git_info "($git_branch)"
    end

    # VENV info
    set -l venv_info ""
    if set -q VIRTUAL_ENV
        set -l python_version (python --version 2>&1 | cut -d' ' -f2)
        set venv_info (basename "$VIRTUAL_ENV") "(py=$python_version)"
    end

    set -l top_line (set_color cyan)"●"\
                    (set_color blue)(prompt_pwd)\
                    (set_color yellow)$git_info \
                    (set_color green)$venv_info\
                    (set_color normal)
    
    # カーソルを一番上の行に移動
    echo -en '\e[s\e[H\e[K'
    
    # 情報を表示
    echo -n $top_line
    
    # カーソルを元の位置に戻す
    echo -en '\e[u'
end

# キー入力のたびに更新
function fish_user_key_bindings
    for mode in insert default visual
        bind -M $mode -m default \r 'commandline -f execute; fish_update_top_line'
    end
end

# プロンプト表示直前にトップラインを更新
function fish_prompt_update_topline --on-event fish_prompt
    fish_update_top_line
end

# ターミナルのリサイズ時にも更新
function on_resize --on-signal WINCH
    fish_update_top_line
end

function clear2
    # clear # NOE: こっちだと、ターミナルをスクロールアップすると履歴が0になってしまう
    echo -en "\033c"
end

function clear_top_line
    clear2
    commandline -f repaint
    fish_update_top_line
    echo -en '\e[1E' # カーソルを次の行の先頭に移動
    fish_prompt
    echo -en '\e[2;3H' # カーソルを▶の直後に移動
end

# トップライン表示を切り替える関数
function toggle_top_line
    if test "$SHOW_TOP_LINE" = "1"
        set -g SHOW_TOP_LINE 0
        fish_clear
    else
        set -g SHOW_TOP_LINE 1
        fish_clear
    end
end

# トップライン表示を切り替えるためのキーバインド（Ctrl+T）
bind \ct 'toggle_top_line'

function fish_clear
    if test "$SHOW_TOP_LINE" = "1"
        clear_top_line
    else
        clear2
        commandline -f repaint
        fish_prompt
    end
end

# ctrl+l に新しい関数をバインド
bind \cl 'fish_clear'

# 初回起動時にトップラインを表示
if status --is-interactive
    fish_update_top_line
end

