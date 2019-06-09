# HHKB Settings

```
spec
HHKB Professional2 Type-S 白／無刻印
（英語配列）
```

https://www.pfu.fujitsu.com/hhkeyboard/type-s/

SWITCH
```
1: ON
2: OFF
3: ON
4: OFF
5: ON
6: OFF
```

# check the key code

```
$ xev | grep keycode
```

# find a keycode

```
$ xmodmap -pke G Print
keycode 107 = Print Sys_Req Print Sys_Req
keycode 134 = Print NoSymbol Print
keycode 218 = Print NoSymbol Print
```

#  Super_R to Print button

```
$ cat .xmodmap
! For HHKB
keycode 134 = Print
```

#  Reload settings

```
$ xmodmap ~/.xmodmap
```
