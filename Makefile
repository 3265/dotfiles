SHELL := /bin/bash
ROOT_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
SETUP_DIR := $(ROOT_DIR)/setup/linux

.DEFAULT: link
.PHONY: link
.ONESHELL:
link:
	bash $(SETUP_DIR)/link.sh

.PHONY: link
.ONESHELL:
test:
	$(MAKE) -C setup/tests

.PHONY: apt fish terminal rust go py js ruby

apt:
	$(MAKE) -C $(SETUP_DIR)/apt

fish:
	$(MAKE) -C $(SETUP_DIR)/terminal fish

terminal:
	$(MAKE) -C $(SETUP_DIR)/terminal terminal

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
