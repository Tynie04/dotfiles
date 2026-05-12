# home/wayland

Home Manager modules for the Wayland desktop environment. All Hyprland ecosystem tools are
configured here declaratively.

```
wayland/
├── default.nix     imports everything in this directory
├── hypr.nix        Hyprland: monitor, keybindings, animations, window rules
├── hyprlock.nix    lock screen: background, clock, input field appearance
├── hypridle.nix    idle timeouts: when to lock and dim the screen
├── waybar.nix      top bar: modules, layout, style (style from .config/waybar/)
├── rofi.nix        app launcher: sources config from .config/rofi/
├── dunst.nix       notifications: size, position, colors, urgency levels
└── wlogout.nix     logout menu: sources layout and icons from .config/wlogout/
```

## What uses xdg.configFile vs HM modules

| Tool      | Managed by           | Config location             |
| --------- | -------------------- | --------------------------- |
| Hyprland  | HM module            | `hypr.nix` settings block   |
| Hyprlock  | HM module            | `hyprlock.nix` settings     |
| Hypridle  | HM service           | `hypridle.nix` settings     |
| Waybar    | HM module + file     | `waybar.nix` + `.config/waybar/style.css` |
| Dunst     | HM service           | `dunst.nix` settings        |
| Rofi      | xdg.configFile only  | `.config/rofi/`             |
| Wlogout   | xdg.configFile only  | `.config/wlogout/`          |

## Hyprpaper

Hyprpaper config lives in `hosts/hermes2/home.nix` instead of here because it needs the
monitor name (`eDP-1`), which is hardware-specific. If you add a monitor, edit that file.

> [!NOTE]
> The wallpaper path in `hosts/hermes2/home.nix` and in `hyprlock.nix` both reference
> `~/dotfiles/wallpapers/Sollee.png`. To change the wallpaper, update both files.

## exec-once

The following programs are started by Hyprland at login via `exec-once` in `hypr.nix`:

* `hyprpaper` - wallpaper daemon
* `waybar` - status bar
* `hyprctl setcursor` - applies the cursor theme for XWayland apps
* `copyq` - clipboard manager
* `dunst` - notification daemon

`polkit-gnome` is started separately as a systemd user service defined in
`hosts/hermes2/default.nix`, not via exec-once.

> [!NOTE]
> Hyprland is configured with `systemd.enable = false`. This means Home Manager services that
> rely on `graphical-session.target` do not start automatically, which is why waybar and dunst
> are launched via exec-once instead of their systemd units.
