{ pkgs, ... }:
{
  imports = [
    ./terminal
    ./programs
    ./wayland
  ];

  home = {
    username = "tijnw";
    homeDirectory = "/home/tijnw";
    stateVersion = "25.11";
  };

  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  programs.home-manager.enable = true;
}
