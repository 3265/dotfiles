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

.PHONY: term_ext
.ONESHELL:
term_ext:
	cd $(SETUP_DIR)
	bash ./linux/tmux.sh
	bash ./linux/ranger.sh
	bash ./arch/fusuma.sh
	reboot

.PHONY: arch_install
.ONESHELL:
arch_install:
	cd $(SETUP_DIR)
	bash ./arch/cui.sh
	bash ./arch/gui.sh
	bash ./linux/vscode.sh

.PHONY: arch
arch: link arch_install term_core term_ext

.PHONY: deb_install
.ONESHELL:
deb_install:
	cd $(SETUP_DIR)
	bash ./deb/cui.sh
	bash ./deb/gui.sh
	bash ./linux/vscode.sh
	bash ./linux/lsd.sh

.PHONY: deb
deb: link deb_install term_core

