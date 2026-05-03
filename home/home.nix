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
}
