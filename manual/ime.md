# IME

# Fcitx configuration settings

Open fcitx-configuration

 
firstly, change default keyboard layout to to English(US).
and update settings following below that:

- Input Method
   - English (US)
   - Mozc
- Global config
   - Trigger Input Method = Empty
   - Active input method = RALT
   - Inactive input method = LALT

# Install basic package of fcitx

```
$ sudo pacman -S --noconfirm fcitx fcitx-mozc fcitx-configtool
```

# Install particular package for fcitx

NOTE: if u don't install particular packages for specific gui tool kit, the IME doesn't work well.
i have got weird behavior on my PC without these packages, like can not input words in gui inputbox.

```
$ sudo pacman -S fcitx-gtk2 fcitx-gtk3 fcitx-qt5
$ yay -S fcitx-qt4
```

# To confirm fcitx status

```
$ fcitx-diagnose
```
