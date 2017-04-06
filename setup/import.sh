#!/bin/bash

# ######################
#  APM
# ######################

# 必須
apm install japanese-menu
apm install file-icons
apm install highlight-column
apm install highlight-line
apm install vim-mode

#apm install atom-alignmen
apm install tag
apm install highlight-selected
apm install script

# 静的構文解析
apm install linter
apm install linter-jshint
apm install linter-coffeelint
#apm install linter-shellcheck

# 入力補完系
apm install autocomplete-plus
apm install autocomplete-snippets
apm install docblockr
apm install autocomplete-paths

# 見た目系
apm install color-picker
apm install pretty-json
apm install atom-prettify
apm install minimap

# 補助系
apm install merge-conflicts
apm install travis-ci-status

# ######################
#  NPM
# ######################

npm install -g json

# build tool
npm instlal -g node-gyp
#sudo apt-get install lib32stdc++6 lib32z1 lib32z1-dev #for enclosejs
# npm install -g enclose

# doc tool
npm install -g jsdoc
# npm install -g documentation
# npm install -g hackmyresume

# package manager
npm install -g bower@1.5.4
# npm install -g meteorite
# npm install -g npm-install-missing

# lint tool
npm install -g jshint
npm install -g eslint
npm install -g coffeelint

# development tool
npm install -g gulp
# npm install -g express
# npm install -g meteor
# npm install -g express-generator
# npm install -g pm2
# npm install -g browserify
# npm install -g mocha
# npm install -g grunt-cli
# npm install -g yeoman
# npm install -g yo
# npm install -g nodedev
# npm install -g nodemon

# other tool
npm install -g mongo-hacker
# npm install -g readme-gen
# npm install -g azure-cli
# npm install -g node-inspector
# npm install -g nmv
# npm install -g vtop
# npm install -g plato
# npm install -g git-stats
# npm install -g nyancat
# npm install -j asciify
# npm install -g hell
# npm install -g issues
# npm install -g todo
# npm install -g js2coffee

# alt js
npm install -g coffee-script
# npm install -g babel
# npm install -g cirru-script
# npm install -g typescript
# npm install -g livescript
# npm install -g purescript
# npm install -g nativescript
# npm install -g sweet.js
# npm install -g jsx

# alt css
# npm install -g less
# npm install -g stylus

# IDE
# npm install -g nuclide
# npm install -g slap

# news
#npm install -g @rafaelrinaldi/hn-cli

# others
# npm install -g gitbook

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

# terminal tools
go get github.com/peco/peco/cmd/peco
go get github.com/mattn/memo
go get github.com/knqyf263/pet
go get github.com/asciimoo/wuzz
go get github.com/githuyb/hub
go get github.com/monochromegane/the_platinum_searcher

# for development
go get -u github.com/githubnemo/CompileDaemon

# ######################
#  python
# ######################

sudo pip install mycli
sudo pip install codemod
sudo pip install httpie
# sudo pip install awscli
