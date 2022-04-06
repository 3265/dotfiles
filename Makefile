SETUP_DIR = ~/dotfiles/setup

.PHONY: link
.ONESHELL:
link:
	cd $(SETUP_DIR)
	bash ./link.sh

.PHONY: term_core
.ONESHELL:
term_core:
	cd $(SETUP_DIR)
	chsh -s /bin/zsh
	bash ./zsh.sh
	bash ./vim.sh

.PHONY: term_ext
.ONESHELL:
term_ext:
	cd $(SETUP_DIR)
	bash ./tmux.sh
	bash ./ranger.sh
	bash ./arch_fusuma.sh
	reboot

.PHONY: arch_install
.ONESHELL:
arch_install:
	cd $(SETUP_DIR)
	bash ./arch_cui.sh
	bash ./arch_gui.sh
	bash ./vscode.sh

.PHONY: arch
arch: link arch_install term_core term_ext

.PHONY: deb_install
.ONESHELL:
deb_install:
	cd $(SETUP_DIR)
	bash ./deb_cui.sh
	bash ./deb_gui.sh
	bash ./vscode.sh
	bash ./lsd.sh

.PHONY: deb
deb: link deb_install term_core
