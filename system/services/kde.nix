{ pkgs, ... }:
{
  services.desktopManager.plasma6.enable = true;

  # plasma.desktop lives in the `sessions` output, not the main package.
  # Add it explicitly so greetd can find it.
  environment.systemPackages = [ pkgs.kdePackages.plasma-workspace.sessions ];
  environment.pathsToLink = [ "/share/wayland-sessions" ];
}
