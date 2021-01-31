SETUP_DIR = ~/dotfiles/setup

.PHONY: link
.ONESHELL:
link:
	cd $(SETUP_DIR)
	bash ./link.sh

.PHONY: terminal-core
.ONESHELL:
terminal-core:
	cd $(SETUP_DIR)
	chsh -s /bin/zsh
	bash ./zsh.sh
	bash ./vim.sh

.PHONY: terminal-ext
.ONESHELL:
terminal-ext:
	cd $(SETUP_DIR)
	bash ./tmux.sh
	bash ./ranger.sh
	bash ./fusuma.sh
	reboot

.PHONY: arch_install
.ONESHELL:
arch_install:
	cd $(SETUP_DIR)
	bash ./arch_cui.sh
	bash ./arch_gui.sh

.PHONY: arch
arch: link arch_install terminal-core terminal-ext

.PHONY: deb_install
.ONESHELL:
deb_install:
	cd $(SETUP_DIR)
	bash ./cui_deb.sh
	bash ./gui_deb.sh

.PHONY: deb
deb: link deb_install terminal-core
