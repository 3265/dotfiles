# dotfiles

## Setup

Install Nix

```bash
sh <(curl -L https://nixos.org/nix/install) --no-daemon
. ~/.nix-profile/etc/profile.d/nix.sh
```

Activate Flakes

```bash
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
```

Apply dotfiles

```bash
git clone https://github.com/3265/dotfiles
cd dotfiles
make update
```
