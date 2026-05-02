# dotfiles

NixOS configuration and dotfiles for hermes2. Hyprland desktop, managed with NixOS modules and Home Manager.

**Stack:** NixOS 25.11 · Hyprland · Waybar · Kitty · Rofi · Dunst · Hyprpaper · Hyprlock

---

## Structure

```
dotfiles/
├── nixos/
│   ├── configuration.nix           # System config (services, users, packages)
│   └── hardware-configuration.nix  # Generated per machine, not committed
├── home/
│   ├── home.nix                    # Home Manager entry point
│   ├── git.nix                     # Git config and SSH signing
│   ├── packages.nix                # User packages
│   └── dotfiles.nix                # Symlinks .config into place
├── .config/
│   ├── hypr/                       # Hyprland, Hyprpaper, Hyprlock, Hypridle
│   ├── waybar/                     # Waybar config and Go scripts
│   ├── kitty/                      # Kitty terminal config
│   └── wlogout/                    # Wlogout layout
└── wallpapers/                     # Wallpaper images
```

---

## How it works

`/etc/nixos/configuration.nix` is a symlink to `nixos/configuration.nix` in this repo. Home Manager runs as a NixOS module, so a single `sudo nixos-rebuild switch` applies both the system config and the user environment at once.

Config files under `.config/` are symlinked into `~/.config/` via `mkOutOfStoreSymlink`, meaning edits to files in this repo take effect **immediately** without a rebuild. Hyprland reloads automatically after every `nixos-rebuild switch`.

> `hardware-configuration.nix` is machine-specific and not committed to git. Each machine keeps its own copy at `~/dotfiles/nixos/hardware-configuration.nix`.

---

## Setting up on a new machine

### 1. Install NixOS

Follow the standard NixOS installation. This generates `/etc/nixos/hardware-configuration.nix`.

### 2. Add the Home Manager channel

```bash
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-25.11.tar.gz home-manager
sudo nix-channel --update
```

### 3. Clone this repo

> Use HTTPS for the initial clone since SSH isn't set up yet.

```bash
git clone https://github.com/Tynie04/dotfiles.git ~/dotfiles
```

### 4. Copy hardware configuration

```bash
cp /etc/nixos/hardware-configuration.nix ~/dotfiles/nixos/hardware-configuration.nix
```

### 5. Symlink NixOS configuration

```bash
sudo ln -sf ~/dotfiles/nixos/configuration.nix /etc/nixos/configuration.nix
```

### 6. Rebuild

```bash
sudo nixos-rebuild switch
```

This installs all packages, applies the system config, and sets up Home Manager including all `.config` symlinks.

### 7. Compile the Waybar scripts

The weather and docker widgets are written in Go and must be compiled on the machine since binaries are architecture-specific.

```bash
cd ~/dotfiles/.config/waybar/scripts/weather-stats && CGO_ENABLED=0 go build -o weather-stats .
cd ~/dotfiles/.config/waybar/scripts/docker-stats && CGO_ENABLED=0 go build -o docker-stats .
```

### 8. Change your password

> The initial password is `changeme`. Change it immediately.

```bash
passwd
```

### 9. Set up SSH key for Git signing and push

```bash
ssh-keygen -t ed25519 -C "your@email.com" -f ~/.ssh/github
```

Add `~/.ssh/github.pub` as both an **authentication key** and a **signing key** in your GitHub account settings. Then switch the remote from HTTPS to SSH:

```bash
cd ~/dotfiles && git remote set-url origin git@github.com:Tynie04/dotfiles.git
```

---

## Day-to-day

| Task | How |
|---|---|
| Edit Hyprland / Waybar config | Edit `~/dotfiles/.config/` directly, changes are live immediately |
| Add a user package | Add to `home/packages.nix`, then rebuild |
| Add a system package | Add to `nixos/configuration.nix`, then rebuild |
| Test changes without cluttering boot entries | `sudo nixos-rebuild test` |
| Apply changes permanently | `sudo nixos-rebuild switch` |
| Save and push changes | `git add -A && git commit -m "..." && git push` |

---

<details>
<summary>Keybindings</summary>

| Keybind | Action |
|---|---|
| `SUPER + Q` | Open terminal (`kitty`) |
| `SUPER + C` | Close active window |
| `SUPER + E` | File manager (`thunar`) |
| `SUPER + Space` | App launcher (`rofi`) |
| `SUPER + V` | Clipboard history (`copyq`) |
| `SUPER + L` | Lock screen (`hyprlock`) |
| `SUPER + F` | True fullscreen (over waybar) |
| `SUPER + SHIFT + F` | Toggle floating |
| `SUPER + SHIFT + S` | Screenshot region → clipboard + `~/Pictures` |
| `Print` | Screenshot region → clipboard + `~/Pictures` |
| `SUPER + M` | Exit Hyprland |
| `SUPER + P` | Pseudo tile (dwindle) |
| `SUPER + J` | Toggle split (dwindle) |
| `SUPER + arrows` | Move focus |
| `SUPER + 1-0` | Switch workspace |
| `SUPER + SHIFT + 1-0` | Move window to workspace |
| `SUPER + scroll` | Scroll through workspaces |
| `SUPER + LMB drag` | Move window |
| `SUPER + RMB drag` | Resize window |

</details>

<details>
<summary>Installed packages</summary>

**System**
`git` `vim` `wget` `curl`

**Terminal & editors**
`kitty` `neovim` `ripgrep` `unzip` `zip` `btop`

**Apps**
`firefox` `vscode` `thunar` `cheese` `obs-studio`

**Hyprland ecosystem**
`waybar` `rofi` `hyprlock` `hypridle` `hyprpaper` `dunst` `wlogout` `copyq` `grim` `slurp` `wl-clipboard` `brightnessctl` `pamixer` `playerctl` `polkit-gnome` `adwaita-icon-theme`

**Network & bluetooth**
`networkmanagerapplet` `blueman`

**Coding**
`claude-code` `python3` `uv` `go`

</details>

---

## Credits

- Waybar config based on [victordantasdev/waybar](https://github.com/victordantasdev/waybar)
