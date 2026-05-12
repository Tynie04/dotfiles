{ ... }:
{
  imports = [
    ./boot.nix
    ./users.nix
  ];

  time.timeZone = "Europe/Brussels";

  services.xserver.xkb.layout = "be";
  console.keyMap = "be-latin1";

  security.polkit.enable = true;
  security.rtkit.enable = true;
  services.gvfs.enable = true;

  system.stateVersion = "25.11";
}
