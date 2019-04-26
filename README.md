# dotfiles  

## Installation

\# | cmd
---|---
1 | sudo apt install git make
2 | git clone https://github.com/mgoldchild/dotfiles
3 | cd dotfiles
4 | make host
5 | :call dein#update() in vim
6 | :UpdateRemotePlugins in vim
7 | cat ~/.ssh/id_rsa.pub # copy to github
8 | git remote remove origin; git remote add origin git@github.com:mgoldchild/dotfiles.git

## Shortcuts

### Ranger

Movement is same as Vim.

File Operations

Shortcut | Desc
---|---
cw|rename current file
dd| cut
dr| reset cut
yy| yank
yr| reset yank
\/| search
dD| delete

File Path Operations

NOTE: need to instal xsel

Shortcut | Desc
---|---
yp| yank file path name
yn| yank file name
yd| yank directory name

File Selection Operation

Shortcut | Desc
---|---
space | select file
v | select all
V | rectangular select 
uv | deselection

Commands

Shortcut | Desc
---|---
: | Execute Range Command
S | Launch sub sheell in current directory
! | Execute Shell Command
du|disk usage
chmod|change permissions


Tabs

Shortcut | Desc
---|---
C-n | create new tab
gn | create new tab
C-w | close current tab
gt or tab | next tab
gT or shift+tab | previous tab
alt+[n] | goto [n]th tab
~ | divide screen by 2 tabs
uq| reopen recent colosed tab

Sort

Shortcut (normal/reverse order) | Desc
---|---
ob / oB | basename (file name)
oe / oE | extension (extension name)
ot / oT | type 
oa / oA | atime
oc / oC | ctime
om / oM | mtime
os / oS | size
on / oN | natural (directory entry)


Edition

Shortcut | Desc
---|---
i | launch pager
w | task view

