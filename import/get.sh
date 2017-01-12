#!/bin/bash

if [ ! -d ~/.go ]
then
  mkdir ~/.go
fi

# go vim completion
go get -u github.com/nsf/gocode
go get -u golang.org/x/tools/cmd/goimports

# terminal tools
go get github.com/peco/peco/cmd/peco
go get github.com/github/hub
go get github.com/monochromegane/the_platinum_searcher

# Go REPL
go get -u github.com/nsf/gocode

# Auto Compiler
go get -u github.com/githubnemo/CompileDaemon

