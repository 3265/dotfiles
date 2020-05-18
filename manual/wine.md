
## Package Installation

```
$ sudo pacman -S wine
$ sudo pacman -S wine-gecko wine-mono
```

## exe installer

```
$ wine hoge.exe
```

## msi installer

```
$ wine msiexec /i hoge.msi
```

## inf installer

```
$ wine rundll32 setupapi,InstallHinfSection DefaultInstall 132 hoge.inf
```

## reset installed wine 

```
$ rm -rf ./wine
```

## REFERENCES:

- http://itmst.blog71.fc2.com/blog-entry-63.html
