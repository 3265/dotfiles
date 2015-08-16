#!/bin/bash

# gitの自動コミット用
# https://gist.github.com/poppen/2817445
# Usage
# sudo apt-get install inotify-tools
# chmod 700 inotify-git.sh
# sh inotify-git.sh { target directory}
#

if [ $# -ne 1 ]; then
	echo "Usage: inotify-git direcotory"
	exit 1
fi

# gitで自動更新したいディレクトリを指定
INOTIFY_GIT_CHECK_DIRECTORY=$1

while true; do
	inotifywait -r -qq -e create,delete,modify,move \
	--exclude '.*\.git/.*' ${INOTIFY_GIT_CHECK_DIRECTORY};
	if [ -e ${INOTIFY_GIT_CHECK_DIRECTORY}/inotify-sleep ]; then
		sleep 300;
	else
		echo "==============="
		echo `date`
		cd ${INOTIFY_GIT_CHECK_DIRECTORY};
		git status -sb
		git add -A
		git commit -m 'auto commit'
		git push origin master
	fi
done
