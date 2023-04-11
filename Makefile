ROOT_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
SETUP_DIR := ~/dotfiles/setup

.DEFAULT: link

.PHONY: link
.ONESHELL:
link:
	cd $(SETUP_DIR)
	bash ./linux/link.sh

.PHONY: term_core
.ONESHELL:
term_core:
	cd $(SETUP_DIR)
	chsh -s /bin/bash
	bash ./linux/zsh.sh
	bash ./linux/vim.sh
	bash ./linux/screen.sh
	bash ./linux/tmux.sh
	bash ./linux/vscode.sh
	bash ./linux/poetry.sh
	bash ./linux/cmds.sh
	sudo chsh -s /usr/bin/fish
	bash ./linux/fisher.sh
	bash ./linux/joshuto.sh
	bash ./linux/poetry.sh
	# reboot

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
	bash ./deb/font.sh
	bash ./deb/cui.sh
	bash ./deb/pyenv.sh
	bash ./deb/lsd.sh
	bash ./deb/fish.sh
	bash ./deb/golang.sh
	bash ./linux/cling.sh
	# bash ./deb/gui.sh

.PHONY: deb
deb: link deb_install term_core

