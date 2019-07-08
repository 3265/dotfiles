make ssh key

```
$ mkdir ~/.ssh/
$ cd ~/.ssh/ 
$ ssh-keygen -t rsa
```

update config

```
$ vim ~/.ssh/config
# github
Host github
    HostName            github.com
    IdentityFile        ~/.ssh/id_rsa
```

change permission

```
$ sudo chmod -R 700 ~/.ssh/ 
$ sudo chmod 600 ~/.ssh/id_rsa
```

test

```
$ ssh -T git@github # test
```

copy to github

```
$ cat ~/.ssh/id_rsa.pub
```
