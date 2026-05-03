{ config, pkgs, ... }:
{
  imports = [
    ./git.nix
    ./packages.nix
    ./dotfiles.nix
    ./shell.nix
  ];

  home.username = "tijnw";
  home.homeDirectory = "/home/tijnw";
  home.stateVersion = "25.11";
  programs.home-manager.enable = true;

  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name    = "Bibata-Modern-Ice";
    size    = 24;
    gtk.enable = true;
    x11.enable = true;
  };
}
