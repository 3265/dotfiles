#!/bin/bash

# ######################
#  Go
# ######################

if [ ! -d ~/.go ]
then
  mkdir ~/.go
fi

# go vim completion
go get -u github.com/nsf/gocode
go get -u golang.org/x/tools/cmd/goimports
go get -u golang.org/x/tools/cmd/gorename

# Essential
go get github.com/knqyf263/pet
go get github.com/peco/peco/cmd/peco

# terminal tools
# go get -u github.com/gokcehan/lf
# go get github.com/mattn/memo
# go get github.com/asciimoo/wuzz
# go get github.com/schachmat/wego
# go get github.com/github/hub
# go get github.com/monochromegane/the_platinum_searcher

# for development
# go get -u github.com/githubnemo/CompileDaemon
