SHELL := /bin/bash
ROOT_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
DEB_DIR := $(ROOT_DIR)/deb

ARGS := $(filter-out $@,$(MAKECMDGOALS))
FIRST_ARG := $(word 1, $(ARGS))
SECOND_ARG := $(word 2, $(ARGS))

############################
#    Nix Home Manager
############################

update:
	git add -N . 2>/dev/null || true
	nix run home-manager/master -- switch --flake .#mike --impure -b backup

generations:
	nix run home-manager/master -- generations

switch:
	nix run home-manager/master -- switch --switch-generation $(SECOND_ARG)

clean:
	nix-collect-garbage -d
	du -sh /nix/store

############################
#       link
############################

.DEFAULT: link
.PHONY: link
.ONESHELL:
link:
	bash $(DEB_DIR)/link.sh

