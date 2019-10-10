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

# Night mode

```
$ gsettings set org.gnome.settings-daemon.plugins.color night-light-temperature 3000
```

https://askubuntu.com/questions/914500/how-to-adjust-the-hue-intensity-of-gnome-night-light


# Backup


- Fist of all, it's need to format media by EXT4 format by gparted.
- After that, update the media permission like below.

```
$ sudo chown -R $USER:$USER /run/media/mike/b1107875-0e05-4587-b144-6e2037fc9306/
```
