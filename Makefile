SETUP_DIR = ~/dotfiles/setup

.ONESHELL:
run:
	cd $(SETUP_DIR)
	bash ./link.sh
	bash ./cui.sh
	bash ./gui.sh
	bash ./zsh.sh
	bash ./vim.sh
	bash ./tmux.sh
	bash ./ranger.sh
	bash ./fusuma.sh
	reboot
