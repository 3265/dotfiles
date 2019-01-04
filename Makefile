SETUP_DIR = ~/dotfiles/setup

.ONESHELL:
host:
	cd $(SETUP_DIR)
	bash ./link.sh
	sudo bash ./cui.sh
	bash ./lang.sh
	bash ./fusuma.sh
	bash ./gui.sh
	bash ./zsh.sh
	bash ./ssh.sh
	bash ./vim.sh
	bash ./tmux.sh
	bash ./ranger.sh
	bash ./ime.sh
	bash ./and.sh
	bash ./cloud.sh
	bash ./font.sh
	reboot # for font

.ONESHELL:
vm:
	HOME=/home/vagrant
	USER=vagrant
	cd $(SETUP_DIR)
	bash ./link.sh
	bash ./cui.sh
	bash ./zsh.sh
	bash ./ssh.sh
	bash ./vim.sh
	bash ./tmux.sh
	bash ./ranger.sh

.ONESHELL:
container:
	cd $(SETUP_DIR)
	bash ./link.sh
	bash ./cui.sh
	bash ./lang.sh
	bash ./zsh.sh
	bash ./ssh.sh
	bash ./vim.sh
	bash ./tmux.sh
	bash ./ranger.sh

