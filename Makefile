SETUP_DIR = ~/dotfiles/setup

ctr:
	cd $(SETUP_DIR)
	bash ./link.sh
	bash ./cui.sh
	bash ./lang.sh
	bash ./zsh.sh
	bash ./ssh.sh
	bash ./vim.sh
	bash ./tmux.sh
	bash ./ranger.sh

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

host:
	cd $(SETUP_DIR)
	bash ./link.sh
	bash ./cui.sh
	bash ./lang.sh
	bash ./fusuma.sh
	bash ./gui.sh
	bash ./zsh.sh
	bash ./ssh.sh
	bash ./vim.sh
	bash ./tmux.sh
	bash ./ranger.sh
	bash ./ime.sh
	bash ./font.sh
	bash ./and.sh
	bash ./gcp.sh
