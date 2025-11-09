# Walker
> A fast, customizable application launcher built with GTK4 and Rust, designed for Linux desktop environments. Walker provides a clean, modern interface for launching applications, running commands, performing calculations, and more. - [Walker](https://github.com/abenz1267/walker)

Install [walker](https://github.com/abenz1267/walker/) and [elephant](https://github.com/abenz1267/elephant)
```bash
yay walker
elephant
```
## Setup Steps

### 1. Enable Elephant Service

Elephant needs to run as a background service in your user environment (not system-level):

```bash
# Enable the systemd user service
elephant service enable

# Start it immediately
systemctl --user start elephant

# Check status
systemctl --user status elephant
```

This creates a service file at `~/.config/systemd/user/elephant.service` that will start automatically on login.

### 2. Install Providers

Install the providers you want to use:

```bash
# Example for Arch Linux
yay -S elephant-desktopapplications elephant-providerlist

# Or build from source and copy to ~/.config/elephant/providers/
```

### 3. Run Walker as a Service

For faster startup times, run Walker as a GApplication service:

```bash
# Start Walker as a service (add this to your autostart)
walker --gapplication-service
```

You can make this persistent by adding it to your desktop environment's autostart. The method depends on your desktop:

**For systemd-based desktops:** Create `~/.config/systemd/user/walker.service`:

```ini
[Unit]
Description=Walker Application Launcher
After=graphical-session.target elephant.service
Requires=elephant.service

[Service]
ExecStart=/usr/bin/walker --gapplication-service
Restart=on-failure

[Install]
WantedBy=default.target
```

Then enable it:

```bash
systemctl --user enable --now walker.service
```

### 4. Bind a Keybind

The fastest way to launch Walker once the service is running is via socket (using netcat):

```bash
nc -U /run/user/1000/walker/walker.sock
```

Or simply:

```bash
walker
```

Bind one of these commands to your preferred keybind in your desktop environment or window manager config. For example:

- **Hyprland**: `bind = SUPER, SPACE, exec, walker`
- **i3/Sway**: `bindsym $mod+space exec walker`
- **KDE**: System Settings → Shortcuts → Add custom shortcut
- **GNOME**: Settings → Keyboard → Custom Shortcuts

The socket call (`nc -U ...`) is faster but doesn't support command-line options, so use `walker` directly if you need to pass options.