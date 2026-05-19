#!/bin/bash

mise use -g node@22
mise use -g python@3.12
mise use -g go@latest
mise use -g rust@stable
mise use -g java@temurin-21

# ruby
mise settings ruby.compile=false
mise use -g ruby@latest

