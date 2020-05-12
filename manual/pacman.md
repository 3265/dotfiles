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

# Use only Speed top 10

```
$ sudo pacman-mirrors --fasttrack 10
```

# Use only Japan Server

```
$ sudo pacman-mirrors --country

::INFO Downloading mirrors from repo.manjaro.org
::INFO User generated mirror list
::------------------------------------------------------------
::INFO Custom mirror file saved: /var/lib/pacman-mirrors/custom-mirrors.json
::INFO Using default mirror file
::INFO Querying mirrors - This may take some time
  0.091 Japan          : http://ftp.tsukuba.wide.ad.jp/Linux/manjaro/
::INFO Writing mirror list
::Japan           : http://ftp.tsukuba.wide.ad.jp/Linux/manjaro/stable
::INFO Mirror list generated and saved to: /etc/pacman.d/mirrorlist

$ cat /etc/pacman.d/mirrorlist

##
## Manjaro Linux default mirrorlist
## Generated on 2020-05-12 22:09
##
## Please use 'pacman-mirrors -f [NUMBER] [NUMBER]' to modify mirrorlist
## (Use 0 for all mirrors)
##

## Country : Japan
Server = http://ftp.tsukuba.wide.ad.jp/Linux/manjaro/stable/$repo/$arch
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

# Upgrade database forcibly

```
$ sudo pacman -Syy
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

NOTE:
- `-Syyu` = `-Syy` + `-Syu`
- if you update your `/etc/pacman.d/mirrorlist`, you need to execute this cmd

```
$ sudo pacman -Syyu
```

# Updagrade packages including AUR repository

```
$ yay -Syu
```

# Remove Package with unused dependencies

```
$ sudo pacman -Rs $pkg
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
- https://forum.manjaro.org/t/pacman-syyu/24160
