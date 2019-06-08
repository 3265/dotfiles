make ex4 file system

```
$ grparted
```


confirm mountpoint

```
$ lsblk
NAME        MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
sdb           8:16   1  29.3G  0 disk
└─sdb1        8:17   1  29.3G  0 part /run/media/mike/5f9e6061-c1ba-4e43-8ecd-8624219810f6
nvme0n1     259:0    0   477G  0 disk
├─nvme0n1p1 259:1    0   300M  0 part /boot/efi
└─nvme0n1p2 259:2    0 476.7G  0 part /
```


change permission

```
$ sudo chown -R $USER:$USER /run/media/mike/5f9e6061-c1ba-4e43-8ecd-8624219810f6
```
