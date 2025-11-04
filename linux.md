# Linux Setup 

Quick setup guide to get a running Linux system. 

1) Install [EndeveourOS](https://endeavouros.com/)
    - Alternatively, try [Nobara](https://nobaraproject.org/).
    - Note that for some reason, it is laggy the first couple of boots, but becomes normal after a while.
2) Install [Hyprland](https://hypr.land/) - using [this install script](https://github.com/JaKooLit/Arch-Hyprland)
    - Use the [dotfiles](https://github.com/JaKooLit/Hyprland-Dots) that comes with the installation for easy to use default installation. 
    - In Hyprland, make sure to configure screen. Press `SUPER + shift + e` and pick configure monitors. Otherwise, refer to the [Monitors Documentation](https://wiki.hypr.land/Configuring/Monitors/)
3) Install basic software
    ```sh
    yay steam
    yay discord
    yay spotify
    ```

## Preliminary customization notes

### Disable focus on hover

Add this somewhere in the hyprland config (e.g. `~/.config/hyprland/hyprland.conf`

```
input {
    follow_mouse = 2
}
```

### Customize logout menu ([wlogout](https://github.com/ArtsyMacaw/wlogout))

Change the logout screen by editing files in `/home/<USER>/.config/wlogout`. Use for instance [_catppuccin_](https://github.com/catppuccin/wlogout). Follow the readme for easy installation.

### Wallpapers

With [JaKooLit dotfiles](https://github.com/JaKooLit/Hyprland-Dots), wallpapers can be found in `/home/<USER>/Pictures/wallpapers`. Maybe use wallpapers from [`/wallpapers`](/wallpapers/).

## Browser stuff

1) Install [uBlock](https://ublockorigin.com/)

## Non Steam games

### Hearthstone

1) Install [Lutris](https://lutris.net/)

### Rocket Leauge

1) Install [Heroic Games Launcher](https://github.com/Heroic-Games-Launcher/HeroicGamesLauncher)
