# Linux

## Setup

Quick setup guide to get a running Linux system. 

1) Install [EndeveourOS](https://endeavouros.com/)
    - Alternatively, try [Nobara](https://nobaraproject.org/), or pure [Arch](https://archlinux.org/) if you're feeling brave.
    - Note that it may be laggy the first couple of boots, but becomes normal after a while. `¯\_(ツ)_/¯`
2) Install basic software
    ```sh
    yay steam
    yay discord
    yay spotify
    ```
3) Install/configure desktop environments or window managers if you want e.g. [[plasma]], [[gnome]], [[mangowc]] [[niri]],  [[hyprland]]  
### Browser stuff

1) Install firefox
2) Install [uBlock](https://ublockorigin.com/)

https://redditenhancementsuite.com/
https://addons.mozilla.org/en-US/firefox/addon/old-reddit-redirect/

Or try [Zen](https://zen-browser.app/).

### Non Steam games

#### Hearthstone

1) Install [Lutris](https://lutris.net/)

#### Rocket Leauge

1) Install [Heroic Games Launcher](https://github.com/Heroic-Games-Launcher/HeroicGamesLauncher)


## Useful Commands

### `systemctl`

example for *dms*

```
systemctl --user status dms  # check status
systemctl --user stop dms    # stop service
systemctl --user disable dms # disable automatic startup
```

The `--user` flag tells `systemctl` to communicate with the **per-user instance** of the `systemd` service manager for the current user, rather than the default **system-wide instance**.
