set fish_greeting # disable greeting

# fish_update_completions

# ##########################
# settings
# ##########################

source ~/.config/fish/settings/basic.fish
source ~/.config/fish/settings/alias.fish
source ~/.config/fish/settings/env.fish
source ~/.config/fish/settings/git.fish

# ##########################
# bindings
# ##########################

function next_d --description 'Go to next directory'
    nextd
    commandline -f repaint
end
function prev_d --description 'Go to next directory'
    nextd
    commandline -f repaint
end
bind \e\[1\;5C next_d # forward-word
bind \e\[1\;5D prev_d # backward-word

function edit_cmd --description 'Edit cmdline in editor'
    set -l f (mktemp)
    set -l p (commandline -C)
    commandline -b > $f
    vim -c set\ ft=fish $f
    commandline -r (more $f)
    commandline -C $p
    rm -f $f
end
bind \cv edit_cmd

function back_to_top_dir --description 'Go to top directory'
    cd ../
    commandline -f repaint
end
bind \cb back_to_top_dir

function prev_d --description 'Go to previous directory'
    prevd
    commandline -f repaint
end
bind "\c[" prev_d

# ##########################
# GIt
# ##########################

# Fish git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch yellow
set __fish_git_prompt_color_upstream_ahead green
set __fish_git_prompt_color_upstream_behind red

# Status Chars
set __fish_git_prompt_char_dirtystate 'Dirty'
set __fish_git_prompt_char_stagedstate 'Staged'
set __fish_git_prompt_char_untrackedfiles 'Untracked'
set __fish_git_prompt_char_stashstate 'Stashed'
set __fish_git_prompt_char_upstream_ahead ' Ahead'
set __fish_git_prompt_char_upstream_behind ' Behind'
