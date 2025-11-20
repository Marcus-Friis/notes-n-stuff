# MangoWC

## Install

Follow [this guide](https://www.tonybtw.com/tutorial/mangowc/).

For Arch Linux, installation is straightforward using the AUR:
```sh
yay -S mangowc-git
```

Then install the required dependencies:
```sh
sudo pacman -Sy foot wl-clipboard wmenu grim slurp swaybg firefox ttf-jetbrains-mono-nerd
```

## Config

Create the `~/.config/mango/config.conf` if it does not already exist. Use [this official template](https://github.com/DreamMaoMao/mangowc/blob/main/config.conf).

**Keyboard layout**
Set danish keyboard layout
```cfg
xkb_rules_layout=dk
```

**Monitor rules**
[docs](https://github.com/DreamMaoMao/mangowc/wiki#monitor-rules).
`monitorrule` - name,mfact,nmaster,layout,transform,scale,x,y,width,height,refreshrate|
```cfg
monitorrule=DP-2,0.55,1,tile,0,1,0,0,3440,1440,144
monitorrule=DP-3,0.55,1,tile,0,1,3440,200,1920,1080,60
```

**Decrease mouse speed**
```cfg
accel_speed=-0.5
accel_profile=0
```

**Keybindings**
Alter the default keybindings in the config file
```cfg
bind=SUPER,Return,spawn,foot
bind=SUPER,q,killclient,
bind=SUPER,d,spawn,wmenu-run -l 10
```

**Create `autostart.sh` and run on startup**
Create a script for stuff that should start e.g. `noctalia-shell`  or `swaybg`
```sh
qs -c ~/.config/quickshell/noctalia-shell/ >/dev/null 2>&1 &  
swaybg -i ~/Desktop/notes-n-stuff/linux/wallpapers/andreas-oberdammer-agMGQamWpzQ-unsplash.jpg >/dev/null 2>&1 &
```
### Noctalia-shell

> A sleek and minimal desktop shell thoughtfully crafted for Wayland. - [noctalia-shell](https://github.com/noctalia-dev/noctalia-shell) 

Install with [this guide](https://docs.noctalia.dev/getting-started/installation/). 