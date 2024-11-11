
.PHONY: terminal
.ONESHELL:
terminal:
	set -e
	bash vim.sh
	bash screen.sh
	bash tmux.sh

.PHONY: fish
.ONESHELL:
fish:
	set -e
	bash fish.sh
	fish fisher.sh
	fisher install jorgebucaran/nvm.fish

	sudo chsh -s /usr/bin/fish
