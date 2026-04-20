# dotfiles

## Repository Layout

- `.config/`: config files linked into `$HOME` or managed by Home Manager
- `nix/`: Home Manager modules
- `deb/`: Debian/Ubuntu setup scripts
- `assets/`: non-runtime assets such as wallpapers and QMK keymaps

## Initial Setup

Base settings

```bash
bash deb/sys/init.sh
bash deb/sys/drivers.sh
bash deb/sys/caps-lock.sh
bash deb/sys/fish.sh
bash deb/sys/font.sh
bash deb/sys/vim.sh
bash deb/sys/nix.sh
```

Link config files and install Nix packages

```bash
make link 
. ~/.nix-profile/etc/profile.d/nix.fish
make update
```
