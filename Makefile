SETUP_DIR = ~/dotfiles/setup

ctr:
	cd $(SETUP_DIR)
	sh ./link.sh
	sh ./cui.sh
	sh ./zsh.sh
	sh ./ssh.sh
	sh ./vim.sh
	sh ./tmux.sh
	sh ./ranger.sh

vm:
	cd $(SETUP_DIR)
	sh ./link.sh
	sh ./cui.sh
	sh ./zsh.sh
	sh ./ssh.sh
	sh ./vim.sh
	sh ./tmux.sh
	sh ./ranger.sh

host:
	cd $(SETUP_DIR)
	sh ./link.sh
	sh ./cui.sh
	sh ./gui.sh
	sh ./zsh.sh
	sh ./ssh.sh
	sh ./vim.sh
	sh ./tmux.sh
	sh ./ranger.sh
	sh ./ime.sh
	sh ./font.sh
	sh ./and.sh
	sh ./gcp.sh
