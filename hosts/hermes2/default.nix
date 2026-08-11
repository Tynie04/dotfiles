{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix

    ../../system/core
    ../../system/nix
    ../../system/hardware/bluetooth.nix
    ../../system/hardware/graphics.nix
    ../../system/network
    ../../system/network/tailscale.nix
    ../../system/programs
    ../../system/services/greetd.nix
    ../../system/services/kde.nix
    ../../system/services/pipewire.nix
    ../../system/services/docker.nix
  ];

environment.variables = {
    XCURSOR_THEME = "Win10OS-Cursors";
    XCURSOR_SIZE = "24";
    TERMINAL = "kitty";
    NH_FLAKE = "/home/tijnw/dotfiles";
  };

  # uinput for controllers / KDE Connect
  boot.kernelModules = [ "uinput" ];
  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="input", OPTIONS+="static_node=uinput"
  '';

  # polkit authentication agent (graphical sudo prompts)
  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };
}
