# ------------------
#  zshrc
# ------------------

# options
source ~/dotfiles/zsh/.zshrc.options

# keybinding
source ~/dotfiles/zsh/.zshrc.keybinding

# misc
source ~/dotfiles/zsh/.zshrc.misc

# complement
source ~/dotfiles/zsh/.zshrc.complement

# prompt
source ~/dotfiles/zsh/.zshrc.prompt

# emulate
source ~/dotfiles/zsh/.zshrc.emulate

# function
source ~/dotfiles/zsh/.zshrc.function

# plugin
source ~/dotfiles/zsh/.zshrc.plugin


# tabtab source for electron-forge package
# uninstall by removing these lines or running `tabtab uninstall electron-forge`
[[ -f /Users/os10/Apps/ryokan/Okami-front/node_modules/tabtab/.completions/electron-forge.zsh ]] && . /Users/os10/Apps/ryokan/Okami-front/node_modules/tabtab/.completions/electron-forge.zsh