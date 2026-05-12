# system

NixOS system modules. Everything here runs at the system level (as root) and affects all users.
These modules are imported by each host via `hosts/<hostname>/default.nix`.

```
system/
├── core/                    fundamental system settings
│   ├── default.nix          imports boot and users, sets locale and timezone
│   ├── boot.nix             systemd-boot EFI bootloader
│   └── users.nix            user accounts and groups
├── hardware/
│   ├── graphics.nix         GPU drivers and VA-API support
│   └── bluetooth.nix        bluetooth and blueman service
├── network/
│   ├── default.nix          networkmanager
│   └── tailscale.nix        tailscale VPN
├── nix/
│   ├── default.nix          nix daemon settings, flake registry, unfree packages
│   └── nh.nix               nh helper tool with automatic generation cleanup
├── programs/
│   ├── default.nix          fish, hyprland, dconf, hyprpaper, xdg portal, plasma6
│   ├── fonts.nix            system fonts
│   └── home-manager.nix     Home Manager as a NixOS module
└── services/
    ├── greetd.nix           tuigreet login manager
    ├── pipewire.nix         audio (replaces pulseaudio)
    └── sunshine.nix         game streaming
```

> [!NOTE]
> If a setting affects only one machine, put it in `hosts/<hostname>/default.nix` instead.
> These modules are meant to be shared across machines if you ever add a second host.
