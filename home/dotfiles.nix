{ config, pkgs, lib, ... }:
let
  dotfiles = "${config.home.homeDirectory}/dotfiles";
  link = path: config.lib.file.mkOutOfStoreSymlink "${dotfiles}/${path}";
in
{
  home.file = {
    # Live symlinks — edit without rebuild
    ".config/hypr/hyprland.conf".source         = link ".config/hypr/hyprland.conf";
    ".config/waybar/config.jsonc".source        = link ".config/waybar/config.jsonc";
    ".config/waybar/style.css".source           = link ".config/waybar/style.css";
    ".config/waybar/reload.sh".source           = link ".config/waybar/reload.sh";

    # Scripts — live symlink to dotfiles
    ".config/waybar/scripts".source = link ".config/waybar/scripts";

    # Wlogout layout
    ".config/wlogout/layout".source = link ".config/wlogout/layout";
  };

  home.activation.reloadHyprland = lib.hm.dag.entryAfter ["writeBoundary"] ''
    if ${pkgs.hyprland}/bin/hyprctl version &>/dev/null 2>&1; then
      ${pkgs.hyprland}/bin/hyprctl reload
    fi
  '';
}
