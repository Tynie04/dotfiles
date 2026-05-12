# home

Home Manager modules. Everything here applies to the user `tijnw` and runs without root access.
The entry point is `default.nix`, which is imported by `flake.nix`.

```
home/
├── default.nix              sets username, home directory, stateVersion, cursor theme
├── programs/
│   └── packages.nix         user packages that do not have their own config module
├── terminal/
│   ├── default.nix          imports shell, git and kitty
│   ├── shell.nix            fish shell and starship prompt
│   ├── emulators/kitty.nix  kitty terminal with colors and font
│   └── programs/git.nix     git identity, SSH signing
└── wayland/
    ├── default.nix          imports all wayland modules
    ├── hypr.nix             hyprland window manager settings and keybindings
    ├── hyprlock.nix         lock screen appearance
    ├── hypridle.nix         idle timeout and lock trigger
    ├── waybar.nix           top bar layout and style
    ├── rofi.nix             application launcher config
    ├── dunst.nix            notification daemon settings
    └── wlogout.nix          logout menu layout and icons
```

## Adding a new program

If the program has no meaningful config, add it to `programs/packages.nix`.

If it has config worth managing declaratively (colors, keybindings, integrations), create a new
`.nix` file in the appropriate subdirectory and import it from the `default.nix` in that folder.

Use `programs.<name>` or `services.<name>` HM options when they exist. Fall back to
`xdg.configFile` for programs without a Home Manager module.

> [!NOTE]
> Programs managed by a Home Manager module (kitty, fish, starship, waybar, dunst, hyprlock,
> hypridle) do not need to be listed in `packages.nix`. The module installs the package automatically.

---

## Git setup

Git is configured in `terminal/programs/git.nix`. Commits are signed automatically using an SSH key.

### What is set

* Username: `Tynie04`
* Email: the GitHub private noreply address
* Signing key: `~/.ssh/github.pub`
* Signing format: SSH (not GPG)
* All commits signed by default

### Setting up on a new machine

The signing key path is hardcoded to `/home/tijnw/.ssh/github.pub`. You need to generate the key
and register it with GitHub before commits will be accepted.

```bash
ssh-keygen -t ed25519 -C "your@email.com" -f ~/.ssh/github
```

Add `~/.ssh/github.pub` to your GitHub account twice:

* Under Settings > SSH and GPG keys > New SSH key, type **Authentication**
* Under Settings > SSH and GPG keys > New SSH key, type **Signing**

> [!IMPORTANT]
> Without the signing key registered in GitHub, your commits will show as unverified.
> Without the authentication key, `git push` to SSH remotes will fail.

If you change the key name or path, update `signing.key` in `terminal/programs/git.nix`
and rebuild.
