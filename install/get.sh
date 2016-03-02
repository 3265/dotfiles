#!/bin/bash

if [ ! -d ~/go ]
then
  mkdir ~/go
fi

go get github.com/peco/peco/cmd/peco
go get github.com/github/hub

go get github.com/monochromegane/the_platinum_searcher

