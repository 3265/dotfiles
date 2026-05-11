SHELL := /bin/bash
ROOT_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
DEB_DIR := $(ROOT_DIR)/setup

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
	bash $(DEB_DIR)/link.sh

