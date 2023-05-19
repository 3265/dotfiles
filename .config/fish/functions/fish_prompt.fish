set -g fish_prompt_pwd_dir_length 4

function fish_prompt
    echo -n '▶ '
end 

function fish_right_prompt
    prompt_pwd
end

