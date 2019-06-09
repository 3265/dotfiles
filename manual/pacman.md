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


