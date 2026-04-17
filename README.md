# dotfiles

## Setup

Base settings

```
bash deb/sys/init.sh
bash deb/sys/drivers.sh
bash deb/sys/caps-lock.sh
bash deb/sys/fish.sh
bash deb/sys/font.sh
bash deb/sys/vim.sh
bash deb/sys/nix.sh
```

Install nix pkgs and links

```bash
make link 
. ~/.nix-profile/etc/profile.d/nix.fish
make update
```
