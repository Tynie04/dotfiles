# home/programs

User packages managed by Home Manager.

```
programs/
├── default.nix     imports packages.nix
└── packages.nix    flat list of home.packages
```

## packages.nix

This is where you add programs that do not need their own config module. If a program has
meaningful settings to configure declaratively, give it its own `.nix` file under the
appropriate subdirectory in `home/` instead.

Programs managed by a Home Manager module are NOT listed here. Those are installed automatically
by their module:

* kitty (via `programs.kitty`)
* fish (via `programs.fish`)
* starship (via `programs.starship`)
* waybar (via `programs.waybar`)
* dunst (via `services.dunst`)
* hyprlock (via `programs.hyprlock`)
* hypridle (via `services.hypridle`)

## Adding a package

Add the package name to the list in `packages.nix`, then rebuild:

```bash
nh os switch ~/dotfiles
```

> [!TIP]
> Not sure what a package is called in nixpkgs? Search at https://search.nixos.org/packages
