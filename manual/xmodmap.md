# Modify Key Map

## Install dependencies

```
$ sudo pacman -S xorg-xev
$ sudo pacman -S xmodmap
$ sudo pacman -S xbindkeys
```

## Check keycode 

in my case, RALT was target

```
$ xev # press RALT

KeyRelease event, serial 37, synthetic NO, window 0x5000001,
    root 0x135, subw 0x0, time 1868483, (404,481), root:(443,576),
    state 0x80, keycode 108 (keysym 0xfe03, ISO_Level3_Shift), same_screen YES,
    XKeysymToKeycode returns keycode: 92
    XLookupString gives 0 bytes:
    XFilterEvent returns: False
```

So key code is 108

another way to confirm

```
$ xbindkeys -mk
Press combination of keys or/and click under the window.
You can use one of the two lines after "NoCommand"
in $HOME/.xbindkeysrc to bind a key.

--- Press "q" to stop. ---
"(Scheme function)"
    m:0x80 + c:108
    Mod5 + ISO_Level3_Shift
X connection to :1 broken (explicit kill or server shutdown).
```

108 is the keycode

## Confirm current keymap

```
$ xmodmap
xmodmap:  up to 4 keys per modifier, (keycodes in parentheses):

shift       Shift_L (0x32),  Shift_R (0x3e)
lock
control     Control_L (0x25),  Control_L (0x42),  Control_R (0x69)
mod1        Alt_L (0x40),  Meta_L (0xcd)
mod2        Num_Lock (0x4d)
mod3
mod4        Super_L (0x85),  Super_R (0x86),  Super_L (0xce),  Hyper_L (0xcf)
mod5        ISO_Level3_Shift (0x5c),  Mode_switch (0xcb)
```

So, now I wanna remove `ISO_Level3_Shift` from mod5 and add Alt_R


## Update xmodmap

Script of .xmodmap will be like below:


```
remove mod5 = ISO_Level3_Shift
keycode 108 = Alt_R
```

reload xmodmap 

```
$ xmodmap .xmodmap
```


## REFERENCES:
- http://haraita9283.blog98.fc2.com/blog-entry-273.html
