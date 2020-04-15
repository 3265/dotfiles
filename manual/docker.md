# add mike to docker group

```
$ sudo systemctl enable docker
$ sudo groupadd docker
$ sudo gpasswd -a mike docker
$ reboot
```
