SETUP_DIR = ~/dotfiles/setup

.ONESHELL:
host:
	cd $(SETUP_DIR)
	bash ./link.sh
	sudo bash ./cui.sh
	bash ./zsh.sh
	bash ./ssh.sh
	bash ./vim.sh
	bash ./tmux.sh
	bash ./ranger.sh
	bash ./lang.sh
	sudo bash ./gui.sh
	sudo bash ./fusuma.sh
	bash ./ime.sh
	bash ./and.sh
	bash ./cloud.sh
	bash ./dict.sh
	bash ./font.sh
	bash ./docker.sh
	bash ./rbenv.sh
	# sudo direnv exec . bash setup/vpn.sh
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

