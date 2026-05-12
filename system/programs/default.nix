{ pkgs, ... }:
{
  imports = [
    ./fonts.nix
    ./home-manager.nix
  ];

  programs = {
    fish.enable = true;
    hyprland.enable = true;
    dconf.enable = true;
  };

  environment.systemPackages = [ pkgs.hyprpaper ];

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
    config.common.default = "*";
  };

  # Plasma6 as fallback / for X11 apps
  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;
}
