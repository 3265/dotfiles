Manjaro setup after installation 

# firstly, update mirrorlist

```
$ sudo pacman-mirrors -f5
```

# update packages and libraries

```
$ sudo pacman -Syu # or -Syuu
```

# Install base-devel

for prevending err of `Can not find strip binary` after i did `makepkg -si` for yay

```
$ sudo pacman -S base-devel
```

# Install yay

```
$ git clone https://aur.archlinux.org/yay.git
$ cd yay
$ makepkg -si
```

# Install Google Chrome 

in order to use 1password

```
$ yay -S --no--confirm google-chrome
```

# register github

```
$ mkdir ~/.ssh/
$ cd ~/.ssh/ 
$ ssh-keygen -t rsa
$ vim ~/.ssh/config
# github
Host github
    HostName            github.com
    IdentityFile        ~/.ssh/id_rsa
$ sudo chmod -R 700 ~/.ssh/ 
$ sudo chmod 600 ~/.ssh/id_rsa
$ cat ~/.ssh/id_rsa.pub
$ ssh -T git@github # test!
```

# clone dotfiles

```
$ git clone git@github.com:mgoldchild/dotfiles.git
```

# VIM with clipboard

```
$ sudo pacman -S gvim
```


# Update GRUB_TIMEOUT 

```
$ sudo vim /etc/default/grub
[sudo] password for mike:
GRUB_DEFAULT=saved
GRUB_TIMEOUT=5  # <==== change to 1
GRUB_TIMEOUT_STYLE=menu
GRUB_DISTRIBUTOR='Manjaro'
GRUB_CMDLINE_LINUX_DEFAULT="quiet"
GRUB_CMDLINE_LINUX=""
$ sudo update-grub
$ reboot
```
  
# Enable SSD Trim

```
$ sudo systemctl enable fstrim.timer
```

# Check for errors

```
$ sudo systemctl --failed
  UNIT                         LOAD   ACTIVE SUB    DESCRIPTION
  ● systemd-modules-load.service loaded failed failed Load Kernel Modules

  LOAD   = Reflects whether the unit definition was properly loaded.
  ACTIVE = The high-level unit activation state, i.e. generalization of SUB.
  SUB    = The low-level unit activation state, values depend on unit type.

  1 loaded units listed. Pass --all to see loaded but inactive units, too.
  To show all installed unit files use 'systemctl list-unit-files'.

$ sudo journalctl -p 3 -xb
-- Logs begin at Thu 2019-06-06 02:40:18 JST, end at Fri 2019-06-07 20:44:34 JST. --
Jun 07 10:18:38 mike-pc systemd-modules-load[226]: Failed to find module 'vboxdrv'
Jun 07 10:18:38 mike-pc systemd-modules-load[226]: Failed to find module 'vboxnetadp'
Jun 07 10:18:38 mike-pc systemd-modules-load[226]: Failed to find module 'vboxnetflt'
Jun 07 10:18:38 mike-pc systemd-modules-load[226]: Failed to find module 'vboxpci'
Jun 07 10:18:38 mike-pc systemd-modules-load[401]: Failed to find module 'vboxdrv'
Jun 07 10:18:38 mike-pc systemd-modules-load[401]: Failed to find module 'vboxnetadp'
Jun 07 10:18:38 mike-pc systemd-modules-load[401]: Failed to find module 'vboxnetflt'
Jun 07 10:18:38 mike-pc systemd-modules-load[401]: Failed to find module 'vboxpci'
Jun 07 10:18:38 mike-pc systemd[1]: Failed to start Load Kernel Modules.
-- Subject: A start job for unit systemd-modules-load.service has failed
-- Defined-By: systemd
-- Support: https://forum.manjaro.org/c/technical-issues-and-assistan
...

```

investigate service

```
$ sudo journalctl -u systemd-modules-load.service
Jun 06 23:24:49 mike-pc systemd[1]: Starting Load Kernel Modules...
Jun 06 23:24:49 mike-pc systemd-modules-load[427]: Failed to find module 'vboxdrv'
Jun 06 23:24:49 mike-pc systemd-modules-load[427]: Failed to find module 'vboxnetadp'
Jun 06 23:24:49 mike-pc systemd-modules-load[427]: Failed to find module 'vboxnetflt'
Jun 06 23:24:49 mike-pc systemd-modules-load[427]: Failed to find module 'vboxpci'
Jun 06 23:24:49 mike-pc systemd[1]: systemd-modules-load.service: Main process exited, code=exited, status=1/FAILU>
Jun 06 23:24:49 mike-pc systemd[1]: systemd-modules-load.service: Failed with result 'exit-code'.
Jun 06 23:24:49 mike-pc systemd[1]: Failed to start Load Kernel Modules.

$ sudo pacman -Qs virtualbox
local/linux316-virtualbox-host-modules 6.0.8-1 (linux316-extramodules)
    Host kernel modules for VirtualBox
local/virtualbox 6.0.8-2
    Powerful x86 virtualization for enterprise as well as home use
```

solutions:
- https://forum.manjaro.org/t/failed-to-load-kernel-modules-virtualbox/28703
- https://unix.stackexchange.com/questions/202396/manjaro-module-vboxdrv-not-found


```
$ pacman -Qs virtualbox-host-modules
local/linux316-virtualbox-host-modules 6.0.8-1 (linux316-extramodules)
    Host kernel modules for VirtualBox

$ uname -r
4.19.45-1-MANJARO

$ sudo pacman -S linux419-virtualbox-host-modules
$ reboot
```
