# Versions

```
$ pacman -V

  .--.                   Pacman v5.1.3 - libalpm v11.0.3
 / _.-' .-.  .-.  .-.    Copyright (C) 2006-2018 Pacman Development Team
 \  '-. '-'  '-'  '-'    Copyright (C) 2002-2006 Judd Vinet
  '--'
                         This program may be freely redistributed under
                         the terms of the GNU General Public License.
```

# Choose JP server

```diff
[core]
Server = ftp://ftp.jaist.ac.jp/pub/Linux/ArchLinux/core/os/$arch
Include = /etc/pacman.d/mirrorlist
```

# Update mirrorlist

```
$ sudo pacman-mirrors -f5
```

# Install package

```
$ sudo -S $pkg
```

# (Dangerous) Upgrade database 

NOTE:
by this cmd is not bad, but this leads directly to partial updates.
Arch doesn't keep old libs around like most distros such as Ubuntu,
so partial updates is not allowed.

```
$ sudo pacman -Sy
```

# Upgrade database and packages

```
$ sudo pacman -Syu
```

# Upgrade database and upgrade/downgrade package


```
$ sudo pacman -Syuu
```

# Upgrade database and packages forcibly

```
$ sudo pacman -Syyu
```

# Updagrade packages including AUR repository

```
$ yay -Syu
```

# How to fix “unable to lock database” error 


```
$ sudo rm /var/lib/pacman/db.lck
```


# lbffi.so.6: cannot open shared object file: No Such file ...

```
sudo ln -sf /usr/lib/libffi.so.7 /usr/lib/libffi.so.6
```

# Trouble Shooting
- https://forum.manjaro.org/t/manjaro-gnome-settings-18-0-and-manjaro-gnome-settings-17-0-are-in-conflict/63701/5
