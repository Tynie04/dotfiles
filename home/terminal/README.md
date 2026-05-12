# home/terminal

Home Manager modules for the terminal environment.

```
terminal/
├── default.nix           imports shell, git and kitty
├── shell.nix             fish shell config and starship prompt
├── emulators/
│   └── kitty.nix         kitty terminal: font, colors, tabs, window
└── programs/
    └── git.nix           git identity and SSH commit signing
```

## shell.nix

Configures Fish as the interactive shell and Starship as the prompt. The prompt format shows
username, current directory (truncated to 4 segments), git branch, and a colored chevron for
command status.

Fish is also enabled at the system level in `system/programs/default.nix` so it is available
as a login shell. The HM module handles the per-user config on top of that.

## kitty.nix

Full Kitty config as a Home Manager module using the `programs.kitty` options. Colors follow
the Catppuccin Frappe palette. Font is JetBrainsMono Nerd Font at size 12.

To change the font size or colors, edit `kitty.nix` and rebuild.

## git.nix

See `home/README.md` for details on the git signing setup and what to configure on a new machine.

> [!NOTE]
> The username and email in `git.nix` are hardcoded. If you fork this config for your own use,
> update `user.name` and `user.email` in `terminal/programs/git.nix`.
