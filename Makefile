SHELL := /bin/bash
ROOT_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
SETUP_DIR := $(ROOT_DIR)/setup/linux

.DEFAULT: link
.PHONY: link
.ONESHELL:
link:
	bash $(SETUP_DIR)/link.sh

.PHONY: apt fish terminal rust go py js ruby test

apt:
	$(MAKE) -C $(SETUP_DIR)/apt

fish:
	$(MAKE) -C $(SETUP_DIR)/fish

terminal:
	$(MAKE) -C $(SETUP_DIR)/terminal

rust:
	$(MAKE) -C $(SETUP_DIR)/rust

go:
	$(MAKE) -C $(SETUP_DIR)/go

py:
	$(MAKE) -C $(SETUP_DIR)/py

js:
	$(MAKE) -C $(SETUP_DIR)/js

ruby:
	$(MAKE) -C $(SETUP_DIR)/ruby

test:
	$(MAKE) -C $(SETUP_DIR)/test
