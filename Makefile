SHELL := /bin/bash
ROOT_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
SETUP_DIR := ~/dotfiles/setup/linux

.DEFAULT: link
.PHONY: link
.ONESHELL:
link:
	cd $(SETUP_DIR)
	set -e
	bash link.sh

.PHONY: terminal
.ONESHELL:
terminal:
	cd $(SETUP_DIR)
	set -e

	# main
	bash apt.sh
	bash fish.sh
	fish fisher.sh
	bash lang.sh
	bash vim.sh
	bash screen.sh
	bash tmux.sh

	# rust
	bash rust/rustup.sh
	bash rust/lsd.sh
	bash rust/mdbook.sh
	bash rust/fastmod.sh

	# go
	bash go/golang.sh
	bash go/ghq.sh
	bash go/hugo.sh

	# py
	bash py/pyenv.sh
	bash py/poetry.sh
	bash py/conda.sh

	# node
	bash js/deno.sh

	# ruby
	bash ruby/rbenv.sh

	sudo chsh -s /usr/bin/fish
	# reboot

.PHONY: install
install: link terminal
