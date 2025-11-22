# niri

> A scrollable-tiling Wayland compositor. - [niri](https://github.com/YaLTeR/niri)

Read the [Arch docs](https://wiki.archlinux.org/title/Niri) for a better understanding of niri and its dependencies, or check out this [youtube tutorial](https://www.youtube.com/watch?v=bjalAgAVIkc).

Quick install with
```
sudo pacman -Syu niri xwayland-satellite xdg-desktop-portal-gnome xdg-desktop-portal-gtk
```

Additional programs that niri has default keybindings to. niri uses _alacritty_ as the terminal (*`Mod+T`*), and *fuzzel* as the application launcher (*`Mod+D`*) by default
```
sudo pacman -S alacritty  # terminal
sudo pacman -S fuzzel     # application launcher
```

## Config

Edit the config in `~/.config/niri/config.kdl`.

Some nice settings to configure are

**Disable mouse acceleration**
In the config file, find the `mouse` section, and set `accel-profile` to `flat` 
```
mouse {
	// off
	// natural-scroll
	// accel-speed 0.2
	accel-profile "flat"
	// scroll-method "no-scroll"
}
``` 

**Configure monitor settings**
From the [Arch niri docs](https://wiki.archlinux.org/title/Niri#3.2)
> First run `niri msg outputs` to get an overview of the outputs recognized by Niri. Then you can apply configs to each monitor. For example to set the HDMI monitor to 2560x1440 60Hz with a 1.2 scaling, and turning off the laptop monitor, set the following:

```
// Ultrawide main display
output "DP-2" {
    mode "3440x1440@120.000"
    scale 1
    transform "normal"
    position x=0 y=-200
}

// Secondary 1080p display (right side)
output "DP-3" {
    mode "1920x1080@60.000"
    scale 1
    transform "normal"
}
```

**Custom keybindings**
Add this to `binds`
```
	// custom binds
	Mod+E hotkey-overlay-title="Open a File explorer: Dolphin" { spawn "dolphin"; }
	Mod+B hotkey-overlay-title="Open a Browser: Firefox" { spawn "firefox"; }
	Mod+S { screenshot; }
```

**Custom window rules**
Steam floating friends by default
```
window-rule {
    match app-id=r#"steam"# title="^Friends List$"
    open-floating true
}
```

**Remove window decorators**
Remove window decorators using the command
```
prefer-no-csd
```

**Add background**
If no *dms*, add backgrounds using [*swaybg*](https://github.com/swaywm/swaybg)
```
swaybg -i /YOUR/BACKGROUND/PATH >/dev/null 3>&1 &
```
Add this to the config as such
```cfg
spawn-sh-at-startup "swaybg -i ~/walls/wall1.png"
```
## niriswitcher

If missing alt+tab, try [niriswitcher](https://github.com/isaksamsten/niriswitcher). Install using

```
yay -S niriswitcher
```

Add the niriswitcher binds

```
    // niri switcher binds
    Alt+Tab repeat=false { spawn "gdbus" "call" "--session" "--dest" "io.github.isaksamsten.Niriswitcher" "--object-path" "/io/github/isaksamsten/Niriswitcher" "--method" "io.github.isaksamsten.Niriswitcher.application" ; }
    Alt+Shift+Tab repeat=false { spawn "gdbus" "call" "--session" "--dest" "io.github.isaksamsten.Niriswitcher" "--object-path" "/io/github/isaksamsten/Niriswitcher" "--method" "io.github.isaksamsten.Niriswitcher.application" ; }
    Alt+Grave repeat=false { spawn "niriswitcherctl" "show" "--workspace"; }
    Alt+Shift+Grave repeat=false { spawn "niriswitcherctl" "show" "--workspace"; } 
```

And add `spawn-at-startup`

```
spawn-at-startup "niriswitcher"
```

## DankMaterialShell

Add [dms](https://github.com/AvengeMedia/DankMaterialShell) to niri with these commands
```sh
yay dms-shell-bin  # install dms
systemctl --user add-wants niri.service dms  # add symlink from niri to dms
```
