# Keymaps

This is a quick reference extracted from the current dotfiles.

## tmux

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
- Split: `prefix` then `|` (vertical), `-` (horizontal)
- Window switch: `prefix` then `p` (prev), `n` (next)
- Window switch (screen-like): `prefix` then `Ctrl-n` (next), `Ctrl-p` (prev)
- Window switch (double prefix): `Ctrl-q` then `Ctrl-q` (prev)

### tmux copy mode

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

### Vim orgmode

Default orgmode mappings. `LocalLeader` is `\` unless `maplocalleader` is set.

- Cycle visibility (folding): `Tab`
- Rotate TODO state: `LocalLeader` then `ct`
- Select TODO keyword: `LocalLeader` then `d`
- TODO keyword previous/next: `Shift-Left` / `Shift-Right`
- Agenda (week): `LocalLeader` then `caa`
- Agenda (all TODOs): `LocalLeader` then `cat`
- Agenda (week, current buffer): `LocalLeader` then `caA`
- Agenda (all TODOs, current buffer): `LocalLeader` then `caT`

## Fish bindings

### Basic

- `Ctrl-l`: clear screen
- `Ctrl-p`: previous command
- `Ctrl-n`: next command
- `Ctrl-v`: edit current command in Vim
- `Ctrl-b`: `cd ../` (back to parent)
- `Esc` (`Ctrl-[`): previous directory (`prevd`)
- `Ctrl-t`: toggle terminal mode

### FZF fish bindings

- `Ctrl-d`: find directory
- `Ctrl-f`: find file
- `Ctrl-r`: autojump
- `Ctrl-h`: search history

FZF default opts:
- `Ctrl-d`: page-down, `Ctrl-u`: page-up

### Emacs-style line editing

- `Ctrl-a`: move to line start
- `Ctrl-b`: backward one character
- `Ctrl-f`: forward one character
- `Ctrl-c`: cancel/interrupt current input

## IME

- `Left Alt`: English mode
- `Right Alt`: Japanese mode
- `Ctrl-;`: paste mode
