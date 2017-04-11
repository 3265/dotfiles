DOTIFLES := "~/dotfiles/"

mac-init:
	cd $(DOTIFLES)
	sh ./setup/link.sh
	sh ./setup/mac.sh
	sh ./setup/zsh.sh
	sh ./setup/tmux.sh
	sh ./setup/vim.sh
	sh ./setup/git.sh
	sh ./setup/nvm.sh
	sh ./setup/pyenv.sh
	sh ./setup/import.sh
	sh ./setup/utils.sh
	source .bash_profile
