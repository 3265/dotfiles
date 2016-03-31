#!/bin/bash

if [ ! -d ~/.go ]
then
  mkdir ~/.go
fi

# go vim completion
go get -u github.com/nsf/gocode

# terminal tools
go get github.com/peco/peco/cmd/peco
go get github.com/github/hub
go get github.com/monochromegane/the_platinum_searcher

# Stock market tracker
go get github.com/michaeldv/mop
cd $GOPATH/src/github.com/michaeldv/mop && make install

# go package manager
go get github.com/tools/godep
