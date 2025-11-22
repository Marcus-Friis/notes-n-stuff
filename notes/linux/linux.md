# Linux

## Setup

Quick setup guide to get a running Linux system. 

1) Install [EndeveourOS](https://endeavouros.com/)
    - Alternatively, try [Nobara](https://nobaraproject.org/), [CachyOS](https://cachyos.org/), or pure [Arch](https://archlinux.org/) if you're feeling brave.
    - Note that it may be laggy the first couple of boots, but becomes normal after a while. `¯\_(ツ)_/¯`
2) Install basic software (use `yay` or `sudo pacman -S PACKAGE-NAME`)
    ```sh
    yay steam
    yay discord
    sudo pacman -S spotify-launcher
    yay obsidian
    ```
3) Install/configure desktop environments or window managers if you want e.g. [[plasma]], [[gnome]], [[niri]], [[mangowc]], [[hyprland]]  
### Browser stuff

1) Install firefox
2) Install [uBlock](https://ublockorigin.com/)

https://redditenhancementsuite.com/
https://addons.mozilla.org/en-US/firefox/addon/old-reddit-redirect/

Or try [Zen](https://zen-browser.app/).

### Zsh shell

Install [zsh](https://wiki.archlinux.org/title/Zsh)
```sh
sudo pacman -S zsh
```

Change the default shell to zsh (requires log out and in to apply)
```sh
chsh -s /usr/bin/zsh
```

Now install [oh-my-zsh](https://ohmyz.sh/)
```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
Now add the [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) plugin. Clone the repository into `$ZSH_CUSTOM/plugins` (by default `~/.oh-my-zsh/custom/plugins`)
```shell
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```
Add the plugin to the list of plugins for Oh My Zsh to load (inside `~/.zshrc`):
```shell
plugins=( 
    # other plugins...
    zsh-autosuggestions
)
```


### Non Steam games

#### Hearthstone

Two options:
1) Install Hearthstone through [Lutris](https://lutris.net/)
2) Add Battlenet installer to Steam, and install through Steam

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
