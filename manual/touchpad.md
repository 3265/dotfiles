NOTE: this is an only for GUI on X.org 


add NaturalScrolling option to InputClass that has pointer or touchpad Identifier
ref https://askubuntu.com/questions/908484/natural-scrolling-in-lubuntu-17-04/1061379

```
$ sudo vim /usr/share/X11/xorg.conf.d/40-libinput.conf
```

the contents of file is below


```40-libinput.conf
Section "InputClass"
    Identifier "libinput pointer catchall"
    MatchIsPointer "on"
    MatchDevicePath "/dev/input/event*"
    Driver "libinput"
    Option "NaturalScrolling" "true"  # <-- add this line
EndSection
Do the same for the touchpad section:

Section "InputClass"
    Identifier "libinput touchpad catchall"
    MatchIsTouchpad "on"
    MatchDevicePath "/dev/input/event*"
    Driver "libinput"
    Option "NaturalScrolling" "true" # <-- add this line
EndSection

```
