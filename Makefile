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
#     base
############################

base:
	$(MAKE) -C $(SETUP_DIR)/cui/base


############################
#     shell
############################
shell:
	$(MAKE) -C $(SETUP_DIR)/cui/shell

############################
#      terminal
############################

terminal:
	$(MAKE) -C $(SETUP_DIR)/cui/terminal font
	$(MAKE) -C $(SETUP_DIR)/cui/terminal ime
	$(MAKE) -C $(SETUP_DIR)/cui/terminal fusuma

############################
#      app
############################

app:
	$(MAKE) -C $(SETUP_DIR)/cui/app go
	#$(MAKE) -C $(SETUP_DIR)/cui/app docker

############################
#      Lang
############################

lang:
	$(MAKE) -C $(SETUP_DIR)/cui/py
	$(MAKE) -C $(SETUP_DIR)/cui/rust
