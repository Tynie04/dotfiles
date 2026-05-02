# dotfiles

NixOS configuration and dotfiles for hermes2. Managed with NixOS modules and Home Manager.

## Structure

```
dotfiles/
├── nixos/
│   ├── configuration.nix        # System configuration (packages, services, users)
│   └── hardware-configuration.nix  # Generated per machine, not committed
├── home/
│   ├── home.nix                 # Home Manager entry point, imports all modules
│   ├── git.nix                  # Git config and SSH signing
│   └── dotfiles.nix             # Symlinks .config files into place, auto-reloads Hyprland
└── .config/
    ├── hypr/                    # Hyprland config
    ├── waybar/                  # Waybar config and scripts
    └── kitty/                   # Kitty terminal config (empty, add kitty.conf when needed)
```

## How it works

`/etc/nixos/configuration.nix` is a symlink to `nixos/configuration.nix` in this repo. NixOS reads it on every rebuild and Home Manager is run as a NixOS module, so a single `sudo nixos-rebuild switch` applies both the system config and the user config.

Config files under `.config/` are symlinked into `~/.config/` by Home Manager using `mkOutOfStoreSymlink`. This means you can edit them directly and changes take effect immediately without a rebuild. Hyprland is reloaded automatically after every rebuild.

`hardware-configuration.nix` is machine-specific and not committed. Each machine keeps its own copy at `~/dotfiles/nixos/hardware-configuration.nix`.

## Setting up on a new machine

### 1. Install NixOS

Follow the standard NixOS installation. This generates `/etc/nixos/hardware-configuration.nix`.

### 2. Add the Home Manager channel

As root, add the Home Manager channel matching your NixOS version:

```bash
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-25.11.tar.gz home-manager
sudo nix-channel --update
```

### 3. Clone this repo

Use HTTPS for the initial clone since the SSH key is not set up yet:

```bash
git clone https://github.com/Tynie04/dotfiles.git ~/dotfiles
```

### 4. Copy hardware configuration

Copy the machine-generated hardware config into the dotfiles directory:

```bash
cp /etc/nixos/hardware-configuration.nix ~/dotfiles/nixos/hardware-configuration.nix
```

### 5. Symlink the NixOS configuration

```bash
sudo ln -sf ~/dotfiles/nixos/configuration.nix /etc/nixos/configuration.nix
```

### 6. Rebuild

```bash
sudo nixos-rebuild switch
```

This installs all packages, applies system config, and sets up Home Manager including the `.config` symlinks.

### 7. Change your password

The initial password is set to `changeme`. Change it immediately after first login:

```bash
passwd  # you will be prompted to enter a new password
```

### 8. Set up SSH key for Git signing and push

The SSH key for Git commit signing is machine-specific and not stored in this repo. Generate a new key and add it to GitHub:

```bash
ssh-keygen -t ed25519 -C "your@email.com" -f ~/.ssh/github
```

Add `~/.ssh/github.pub` as both an authentication key and a signing key in your GitHub account settings. Then switch the remote from HTTPS to SSH:

```bash
cd ~/dotfiles
git remote set-url origin git@github.com:Tynie04/dotfiles.git
```

## Day-to-day usage

**Edit Hyprland or Waybar config:** Edit the files directly under `~/dotfiles/.config/`. Changes are live immediately. For Hyprland, run `hyprctl reload` if you want to apply them without waiting for a rebuild.

**Add a system package:** Add it to `environment.systemPackages` in `nixos/configuration.nix`, then rebuild.

**Add a user package:** A `home/packages.nix` module can be added and imported in `home/home.nix` for packages managed at the user level via Home Manager.

**Rebuild after config changes:**

```bash
sudo nixos-rebuild switch
```

## Credits

- Waybar config based on [victordantasdev/waybar](https://github.com/victordantasdev/waybar)
