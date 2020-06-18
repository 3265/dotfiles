# Snap

## An Example of installing VoTT

Download snap file of VoTT from github release page.

Install snapd

```
$ sudo pacman -S snapd
```

Enable snapd 

```
$ sudo systemctl enable --now snapd.socket
```

Install vott file via cli

```
$ sudo snap install --dangerous vott-2.2.0-linux.snap
2020-06-14T12:17:57+09:00 INFO Waiting for automatic snapd restart...
vott 2.2.0 installed
sudo snap install --dangerous vott-2.2.0-linux.snap  2.40s user 1.05s system 2% cpu 2:25.85 total
```

Launch

```
$ sudo vott
```

## REFERENCES:

- https://snapcraft.io/docs/installing-snap-on-arch-linux
