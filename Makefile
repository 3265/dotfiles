SETUP_DIR = ~/dotfiles/setup

.PHONY: link
.ONESHELL:
link:
	cd $(SETUP_DIR)
	bash ./link.sh

.PHONY: install
.ONESHELL:
install:
	cd $(SETUP_DIR)
	bash ./cui.sh
	bash ./gui.sh

.PHONY: terminal
.ONESHELL:
terminal:
	cd $(SETUP_DIR)
	chsh -s /bin/zsh
	bash ./zsh.sh
	bash ./vim.sh
	bash ./tmux.sh
	bash ./ranger.sh
	bash ./fusuma.sh
	reboot

.PHONY: arch
arch: link install terminal

.PHONY: link_deb
.ONESHELL:
link_deb:
	cd $(SETUP_DIR)
	bash ./link_deb.sh

.PHONY: install_deb
.ONESHELL:
install_deb:
	cd $(SETUP_DIR)
	bash ./cui_deb.sh

.PHONY: deb
deb: link_deb install_deb
