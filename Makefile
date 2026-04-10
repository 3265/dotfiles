SHELL := /bin/bash
ROOT_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
SETUP_DIR := $(ROOT_DIR)/setup

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
	bash $(SETUP_DIR)/link.sh

############################
#      test
############################

.PHONY: test
.ONESHELL:
test:
	$(MAKE) -C $(SETUP_DIR)/_tests

############################
#     others
############################

github:
	bash $(SETUP_DIR)/github.sh $(SECOND_ARG)

nix:
	bash $(SETUP_DIR)/nix.sh $(SECOND_ARG)

font:
	bash $(SETUP_DIR)/input/font.sh $(SECOND_ARG)

ime:
	bash $(SETUP_DIR)/input/ime.sh $(SECOND_ARG)

fish:
	bash $(SETUP_DIR)/input/fish.sh $(SECOND_ARG)
