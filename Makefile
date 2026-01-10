SHELL := /bin/bash
ROOT_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
SETUP_DIR := $(ROOT_DIR)/setup

ARGS := $(filter-out $@,$(MAKECMDGOALS))
FIRST_ARG := $(word 1, $(ARGS))
SECOND_ARG := $(word 2, $(ARGS))


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

.PHONY: test2
.ONESHELL:
test2:
	echo $(SECOND_ARG)
	$(MAKE) -C $(SETUP_DIR)/_tests test2

############################
#     github
############################

github:
	bash $(SETUP_DIR)/github.sh $(SECOND_ARG)


############################
#    Nix Home Manager
############################

update:
	git add -N . 2>/dev/null || true
	nix run home-manager/master -- switch --flake .#mike --impure -b backup

generations:
	nix run home-manager/master -- generations

switch:
	nix run home-manager/master -- switch --switch-generation $(FIRST_ARG)

clean:
	nix-collect-garbage -d
	du -sh /nix/store
