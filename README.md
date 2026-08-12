# dotfiles

Personal NixOS configuration for **hermes2**. Built with flakes and Home Manager as a NixOS module,
meaning a single `nh os switch ~/dotfiles` rebuilds both the system and the user environment at once.

Everything is declarative. The system state is fully described by this repository. If something
breaks, roll back through the bootloader. If you set up a new machine, clone and rebuild.

> [!IMPORTANT]
> This is a personal learning project. I am still figuring out NixOS, so some things are probably
> not done in the most optimal or idiomatic way. It works for me, but take it as inspiration rather
> than a reference for best practices.

![NixOS](https://img.shields.io/badge/NixOS-unstable-5277C3?style=for-the-badge&logo=nixos&logoColor=white)
![Hyprland](https://img.shields.io/badge/Hyprland-Wayland-58E1FF?style=for-the-badge&logo=wayland&logoColor=white)
![Home Manager](https://img.shields.io/badge/Home_Manager-module-7EBAE4?style=for-the-badge&logo=nixos&logoColor=white)
![Fish](https://img.shields.io/badge/Fish-shell-4AAB9B?style=for-the-badge&logo=fish&logoColor=white)

---

## Stack

| Component      | Tool                        |
| -------------- | --------------------------- |
| OS             | NixOS (unstable)            |
| Window manager | Hyprland                    |
| Shell          | Caelestia (Quickshell)      |
| Bar            | Caelestia bar               |
| Notifications  | Caelestia                   |
| Launcher       | Caelestia launcher          |
| Clipboard      | cliphist (via rofi dmenu)   |
| Terminal       | Kitty                       |
| Shell (fish)   | Fish                        |
| Prompt         | Starship                    |
| Wallpaper      | Hyprpaper + Caelestia       |
| Lock screen    | Hyprlock (via Caelestia)    |
| Idle daemon    | Hypridle                    |
| Display mgmt   | nwg-displays                |
| Login manager  | greetd                      |

---

## Structure

```
dotfiles/
├── flake.nix                    entry point, defines nixosConfigurations.hermes2
├── flake.lock                   pinned dependency versions
├── hosts/
│   └── hermes2/                 per-machine overrides and hardware config
├── system/                      NixOS system modules, applied system-wide
│   ├── core/                    boot loader, users, locale, timezone, polkit
│   ├── hardware/                graphics drivers, bluetooth
│   ├── network/                 networkmanager, tailscale
│   ├── nix/                     nix daemon settings, nh, flake registry
│   ├── programs/                system programs, fonts, xdg portal, home-manager
│   └── services/                greetd, pipewire
├── home/                        Home Manager modules, applied per-user
│   ├── programs/                user package list
│   ├── terminal/                kitty, fish, starship, git
│   └── wayland/                 hyprland, caelestia, hyprlock, hypridle, rofi
├── .config/                     raw config files sourced by HM modules
│   ├── rofi/                    rofi theme (used for clipboard dmenu)
│   └── wlogout/                 wlogout layout and icons (fallback)
└── wallpapers/                  wallpaper images
```

> [!NOTE]
> Each subdirectory has its own README explaining what lives there, what each file does,
> and what to change when setting up on a new machine.

---

## How it works

`flake.nix` defines a single NixOS configuration called `hermes2`. It imports the host entry point
at `hosts/hermes2/`, which pulls in all the `system/` modules. Home Manager runs as a NixOS module,
so user config is applied in the same rebuild pass as system config. There is no separate
`home-manager switch` step.

Caelestia is installed via flake inputs (`caelestia-shell` and `caelestia-cli`). Its user config
(`shell.json`) and any QML customizations are managed declaratively via `xdg.configFile` in
`home/wayland/quickshell.nix`, so they are fully reproduced on a fresh install.

> [!IMPORTANT]
> Nix flakes only see files that are tracked by git. Always run `git add` on new or changed files
> before running `nh os switch`, otherwise Nix will silently ignore your changes.

---

## Setting up on a new machine

### 1. Install NixOS

Follow the standard NixOS installation guide. The installer generates a `hardware-configuration.nix`
for your specific machine. Keep it, you will need it in step 3.

### 2. Clone this repository

> [!NOTE]
> Use HTTPS for the first clone since SSH keys are not set up yet.

```bash
nix-shell -p git --run "git clone https://github.com/Tynie04/dotfiles.git ~/dotfiles"
```

### 3. Rename the host (optional)

The hostname is defined in one place in `flake.nix`:

```nix
let
  hostName = "hermes2";
in
```

To use a different hostname:

1. Change `hostName` in `flake.nix`
2. Rename the host directory: `mv hosts/hermes2 hosts/yourname`
3. Update the two `./hosts/hermes2` path references in `flake.nix` to `./hosts/yourname`

### 4. Add the hardware configuration

Copy the generated hardware config into the host directory:

```bash
cp /etc/nixos/hardware-configuration.nix ~/dotfiles/hosts/hermes2/hardware-configuration.nix
git -C ~/dotfiles add hosts/hermes2/hardware-configuration.nix
```

For a different machine, see `hosts/README.md` for how to create a new host.

### 5. First rebuild

```bash
sudo nix --experimental-features "nix-command flakes" nixos-rebuild switch --flake ~/dotfiles#hermes2
```

After this first rebuild, `nh` is installed and flakes are enabled permanently. Use `nh` from now on:

```bash
nh os switch ~/dotfiles
```

### 6. Change your password

> [!WARNING]
> The initial password in `system/core/users.nix` is `changeme`. Change it immediately after first login.

```bash
passwd
```

### 7. Set up SSH for GitHub

Generate a key and add it to your GitHub account as both an authentication key and a signing key.

```bash
ssh-keygen -t ed25519 -C "your@email.com" -f ~/.ssh/github
cat ~/.ssh/github.pub
```

Add the public key in GitHub under Settings > SSH and GPG keys, once for Authentication and once
for Signing. Then switch the git remote to SSH:

```bash
cd ~/dotfiles
git remote set-url origin git@github.com:Tynie04/dotfiles.git
```

### 8. Clone the caelestia shell config

Caelestia's packages are installed by Nix, but the QML shell config must be cloned separately.
The `shell.json` user config and QML customizations are applied automatically by Home Manager,
but the base shell needs to be cloned first:

```bash
git clone https://github.com/caelestia-dots/shell ~/.config/quickshell/caelestia
```

### 9. Set the wallpaper

After logging into Hyprland, set the caelestia wallpaper and colour scheme:

```bash
caelestia wallpaper -f ~/dotfiles/wallpapers/caelestia-default.webp
caelestia scheme set -n dynamic
```

### 10. Configure monitors

If you have multiple monitors, use nwg-displays to set up their layout:

```bash
nwg-displays
```

Apply the layout — it writes to `~/.config/hypr/monitors.conf` which is automatically sourced
by Hyprland.

---

## Day-to-day usage

| Task                              | How                                                             |
| --------------------------------- | --------------------------------------------------------------- |
| Apply any config change           | `nh os switch ~/dotfiles`                                       |
| Add a user package                | Add to `home/programs/packages.nix`, then rebuild              |
| Add a system service or program   | Edit the relevant file under `system/`, then rebuild           |
| Add a program with its own config | Create a `.nix` file, import it in the parent `default.nix`   |
| Roll back a bad build             | Reboot and select a previous generation in the bootloader      |
| Clean up old generations          | `nh clean all` (also runs automatically, kept for 30 days)     |
| Push changes to GitHub            | `git add -A && git commit -m "..." && git push`                |
| Toggle between caelestia/waybar   | `SUPER + SHIFT + Q`                                            |

---

## Keybindings

> [!NOTE]
> The keyboard layout is Belgian (be). Workspace keys use Belgian key names in the config
> (ampersand, eacute, quotedbl, etc.) but correspond to the number row 1 through 0.

| Keybind              | Action                                        |
| -------------------- | --------------------------------------------- |
| SUPER + Q            | Open terminal (kitty)                         |
| SUPER + B            | Open browser (firefox)                        |
| SUPER + C            | Close active window                           |
| SUPER + E            | File manager (dolphin)                        |
| SUPER + Space        | App launcher (caelestia)                      |
| SUPER + V            | Clipboard history picker                      |
| SUPER + SHIFT + V    | Clear clipboard history                       |
| SUPER + L            | Lock screen                                   |
| SUPER + F            | Fullscreen                                    |
| SUPER + SHIFT + F    | Toggle floating                               |
| SUPER + SHIFT + S    | Screenshot (freeze + region) to clipboard     |
| Print                | Screenshot region to clipboard                |
| SUPER + N            | Caelestia dashboard                           |
| SUPER + SHIFT + N    | Caelestia notification sidebar                |
| SUPER + Tab          | Caelestia utilities panel                     |
| SUPER + K            | Caelestia bar (workspaces/tray)               |
| SUPER + SHIFT + Q    | Toggle caelestia / waybar fallback            |
| CTRL + ALT + Delete  | Session menu                                  |
| SUPER + M            | Exit Hyprland                                 |
| SUPER + D            | Switch to previous workspace                  |
| SUPER + P            | Pseudo tile (dwindle)                         |
| SUPER + J            | Toggle split (dwindle)                        |
| SUPER + arrow keys   | Move focus                                    |
| SUPER + 1 through 0  | Switch workspace                              |
| SUPER + SHIFT + 1-0  | Move window to workspace                      |
| SUPER + scroll       | Scroll through workspaces                     |
| SUPER + LMB drag     | Move window                                   |
| SUPER + RMB drag     | Resize window                                 |

---

## Credits

Caelestia shell by [caelestia-dots](https://github.com/caelestia-dots).
