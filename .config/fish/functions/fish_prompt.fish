# プロンプトモードを制御する変数（0: シンプル、1: 詳細）
set -g PROMPT_MODE 1

set -g fish_prompt_pwd_dir_length 4

function fish_prompt
    set -l last_status $status

    if test "$PROMPT_MODE" = "1"
        # 詳細モード（2行）

        # First line
        set -l prompt_info

        # git
        set -l git_info (__fish_git_prompt "%s")
        if test -n "$git_info"
            set -a prompt_info (set_color yellow)'('(set_color normal)$git_info(set_color yellow)')'(set_color normal)
        end

        # python
        set -l python_version (python --version 2>&1 | cut -d' ' -f2)
        set -a prompt_info (set_color green)"py=$python_version"(set_color normal)

		if set -q VIRTUAL_ENV
            set -l venv_name (basename (dirname $VIRTUAL_ENV))
		    set -a prompt_info (set_color green)"($venv_name)"(set_color normal)
		end

        # nvm
        if type -q nvm
            set -l node_version (nvm current 2>/dev/null)
            if test -n "$node_version"
                set -a prompt_info (set_color magenta)"node=$node_version"(set_color normal)
            end
        end

        # prompt symbol
        echo -n (set_color yellow)"┌──"(set_color normal)" "
        echo -n (set_color blue)(prompt_pwd)(set_color normal)
        for info in $prompt_info
            echo -n " $info"
        end
        echo
        echo -n (set_color yellow)"└─▶"(set_color normal)" "
    else
        # Second line (シンプルモードの場合はこれだけ表示)
        echo -n (set_color yellow)"▶"(set_color normal)" "
    end
end

function toggle_prompt_mode
    if test "$PROMPT_MODE" = "1"
        set -g PROMPT_MODE 0
        clear2
    else
        set -g PROMPT_MODE 1
        clear2
    end
    commandline -f repaint
end


function clear2
    echo -en "\033c"
end

# プロンプトモードを切り替えるためのキーバインド
bind \ct 'toggle_prompt_mode'

# 初回起動時に詳細モードで開始
if status --is-interactive
    function __initial_prompt_mode --on-event fish_prompt
        if not set -q __fish_initial_mode_set
            set -g __fish_initial_mode_set 1
            set -g PROMPT_MODE 1
        end
    end
end

