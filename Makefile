SETUP_DIR = ~/dotfiles/setup

.PHONY: link
.ONESHELL:
link:
	cd $(SETUP_DIR)
	bash ./linux/link.sh

.PHONY: term_core
.ONESHELL:
term_core:
	cd $(SETUP_DIR)
	chsh -s /bin/zsh
	bash ./linux/zsh.sh
	bash ./linux/vim.sh
	bash ./linux/screen.sh
	bash ./linux/tmux.sh
	bash ./linux/vscode.sh
	reboot

.PHONY: arch_install
.ONESHELL:
arch_install:
	cd $(SETUP_DIR)
	bash ./arch/cui.sh
	bash ./arch/gui.sh
	bash ./arch/fusuma.sh

.PHONY: arch
arch: link arch_install term_core

.PHONY: deb_install
.ONESHELL:
deb_install:
	cd $(SETUP_DIR)
	bash ./deb/cui.sh
	# bash ./deb/gui.sh
	bash ./deb/lsd.sh

.PHONY: deb
deb: link deb_install term_core

