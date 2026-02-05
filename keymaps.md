# Keymaps

This is a quick reference extracted from the current dotfiles.

## Tmux

### Basic

- Prefix: `Ctrl-q`
- Reload config: `prefix` then `r`
- Rename window: `prefix` then `,`
- New window: `prefix` then `c`
- Close pane: `prefix` then `x`
- Cycle layout: `prefix` then `Space`
- Pane move: `prefix` then `h/j/k/l`
- Pane move (Ctrl): `prefix` then `Ctrl-h/j/k/l`
- Window move (Ctrl): `prefix` then `Ctrl-h` (prev), `Ctrl-l` (next)
- Pane resize: `prefix` then `H/J/K/L`
- Split: `prefix` then `|` (vertic
- Window switch: `prefix` then `p` (prev), `n` (next)
- Window switch (screen-like): `prefix` then `Ctrl-n` (next), `Ctrl-p` (prev)
- Window switch (double prefix): `Ctrl-q` then `Ctrl-q` (prev)

### Copy mode

- Enter copy mode: `Ctrl-q` then `[`
- Select line (visual line): `Ctrl-q` then `Shift-v`
- Select word: `Ctrl-q` then `Space`
- Yank/copy selection: `Ctrl-q` then `y`

## GNU Screen

- Prefix: `Ctrl-z` then `z` (escape key is `^Z` with `z` as the escape char)
- Window next: `Ctrl-z` then `n`
- Window previous: `Ctrl-z` then `p`
- Window title: `Ctrl-z` then `Shift-a`
- Window switch (double prefix): `Ctrl-z` then `Ctrl-z` (prev)

## Vim

### Basic

- Clear search highlight: `Ctrl-n` (normal/visual/insert)
- Tab previous: `Ctrl-t` then `Ctrl-t` or `Ctrl-t` then `h` / `Ctrl-h`
- Tab next: `Ctrl-t` then `l` / `Ctrl-l`
- Resize window: `Ctrl-w` then `H/J/K/L`
- Resize window (no Ctrl-w): `H/J/K/L`
- Quick close: `Z` or `q`
- NERDTree toggle: `Ctrl-e`
- Marks list: `Ctrl-m`
- Leader: `Space`
- Leader example: `Leader` then `a`

### NerdTree

- Toggle tree: `Ctrl-e`
- Show hidden files: enabled (`NERDTreeShowHidden=1`)
- Open node: `Enter` or `o`
- Open in new tab: `t` (`T` keeps focus in NERDTree)
- File operations menu: `m` (create/rename/delete/copy/move, etc.)
- In the `m` menu: `a` = add child (file/dir), `d` = delete
- Show/hide NERDTree quick help: `?`

## Emacs

### Basic

- `Ctrl-s`: Save buffer
- `Ctrl-t h`: Previous tab
- `Ctrl-t l`: Next tab
- `Ctrl-t Ctrl-h`: Previous tab
- `Ctrl-t Ctrl-l`: Next tab
- `Ctrl-x Ctrl-s`: Save buffer
- `Ctrl-x Ctrl-f`: Find file
- `Ctrl-x Ctrl-c`: Quit Emacs
- `Ctrl-g`: Cancel/Quit
- `Alt-x`: Execute command
- `Ctrl-c r`: Reload current buffer config (`eval-buffer`)
- `Ctrl-u` (Evil normal): Scroll half-page up

### NeoTree

- Toggle tree: `Ctrl-e` (Evil normal) / `F8`
- Close tree: `q` or `Ctrl-e` (inside NeoTree)
- Open file/directory: `Enter` or `o`
- Open file in new Emacs tab: `t`
- Show hidden files: enabled

### Org mode

- Cycle visibility: `Tab`
- Cycle global visibility: `Shift-Tab`
- Insert heading: `Alt-Enter`
- Promote/Demote heading: `Alt-Left` / `Alt-Right`
- Move subtree up/down: `Alt-Up` / `Alt-Down`
- Cycle TODO state: `Ctrl-c Ctrl-t`
- Insert TODO heading: `Alt-Shift-Enter`
- Schedule item: `Ctrl-c Ctrl-s`
- Deadline item: `Ctrl-c Ctrl-d`
- Insert timestamp: `Ctrl-c .`
- Toggle checkbox: `Ctrl-c Ctrl-c`
- Insert/Edit link: `Ctrl-c Ctrl-l`
- Set tags: `Ctrl-c Ctrl-q`
- Refile subtree: `Ctrl-c Ctrl-w`
- Export dispatch: `Ctrl-c Ctrl-e`
- Sparse tree (search): `Ctrl-c /`
- Promote/Demote subtree: `Alt-Shift-Left` / `Alt-Shift-Right`

## Fish bindings

### Basic

- `Ctrl-l`: clear screen
- `Ctrl-p`: previous command
- `Ctrl-n`: next command
- `Ctrl-v`: edit current command in Vim
- `Ctrl-b`: `cd ../` (back to parent)
- `Esc` (`Ctrl-[`): previous directory (`prevd`)
- `Ctrl-t`: toggle terminal mode

### Emacs-style line editing

- `Ctrl-a`: move to line start
- `Ctrl-e`: move to line end
- ~~`Ctrl-b`: backward one character~~
- ~~`Ctrl-f`: forward one character~~
- `Ctrl-u`: kill from cursor to beginning of line
- `Ctrl-k`: kill from cursor to end of line

### FZF bindings

- `Ctrl-d`: find directory
- `Ctrl-f`: find file
- `Ctrl-r`: autojump
- `Ctrl-h`: search history

## IME

- `Left Alt`: English mode
- `Right Alt`: Japanese mode
- `Ctrl-;`: paste mode

## VS Code

### Terminal

- `Ctrl-e`: move cursor to line start (`cursorHome`)
- `Ctrl-k`: delete to end of line (`deleteAllRight`)

### Markdown preview

- `Ctrl-e` (editor): open Markdown preview
- `Ctrl-e` (preview): close active preview tab
