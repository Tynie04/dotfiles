{ config, ... }:
let
  wallpaper = "${config.home.homeDirectory}/dotfiles/wallpapers/Sollee.png";
in
{
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = ${wallpaper}
    splash = false

    wallpaper {
      monitor = eDP-1
      path = ${wallpaper}
      fit_mode = cover
    }
  '';
}
