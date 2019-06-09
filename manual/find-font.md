# find ttf from character

ref https://github.com/jaagr/polybar/wiki/Fonts

# need to install module

```
$ perl -MCPAN -e 'install Font::FreeType'
```

# Usage

```
$ perl ~/dotfiles/scripts/find-font.pl "😀"
```


# find a character from character code

```
$ fc-list | grep "Noto"
$ fc-cache # to reflesh cache
$ fc-match "NotoSansSymbols2-Regular"
$ gucharmap # to find a character from character code
$ # open https://nerdfonts.com/ # to get character code
```
