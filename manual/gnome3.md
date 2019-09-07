i configure out gnome 3 thorough gnome-tweakes

# installation

```
$ sudo pacman -S gnome-tweaks
```

# Settings

I updated settings like following below 

- Background
  - Universe.jpg
- TouchPad
  - Natural Scrolling: ON
- Online Accounts
  - Google

# Gnome-tweaks

I updated settings like following below that:

- Appearance
  - Application: Yaru-dark
  - Sound: Yaru
- General
  - Animations: false
- Top Bar
  - All true-
- Keyboard & Mouse
  - Emacs Input: Enabled

# Capslock to ctrl

```
$ gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:nocaps']"
```

# Reload gnome-extensions

```
Press Alt + F2 and then enter r in the dialog box
```
see https://askubuntu.com/questions/75604/why-does-users-theme-extension-not-show-up-under-gnome-tweak-tool
