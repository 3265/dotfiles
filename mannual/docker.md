# add mike to docker group

```
$ sudo groupadd docker
$ sudo gpasswd -a mike docker
$ sudo systemctl restart docker
```
