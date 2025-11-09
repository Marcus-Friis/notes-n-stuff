## Hyprland

Use Hyprland if you're not feeling KDE or Gnome or whatever.

Install [Hyprland](https://hypr.land/) - using [this install script](https://github.com/JaKooLit/Arch-Hyprland)
- Use the [dotfiles](https://github.com/JaKooLit/Hyprland-Dots) that comes with the installation for easy to use default installation. 
- In Hyprland, make sure to configure screen. Press `SUPER + shift + e` and pick configure monitors. Otherwise, refer to the [Monitors Documentation](https://wiki.hypr.land/Configuring/Monitors/)

### Preliminary customization notes

#### Disable focus on hover

Add this somewhere in the hyprland config (e.g. `~/.config/hyprland/hyprland.conf`

```
input {
    follow_mouse = 2
}
```

#### Wallpapers

With [JaKooLit dotfiles](https://github.com/JaKooLit/Hyprland-Dots), wallpapers can be found in `/home/<USER>/Pictures/wallpapers`. Maybe use wallpapers from [`/wallpapers`](/wallpapers/).

#### Customize logout menu ([wlogout](https://github.com/ArtsyMacaw/wlogout))

Change the logout screen by editing files in `/home/<USER>/.config/wlogout`. Use for instance [_catppuccin_](https://github.com/catppuccin/wlogout). Follow the readme for easy installation.