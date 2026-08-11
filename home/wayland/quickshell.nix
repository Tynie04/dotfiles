{ inputs, pkgs, ... }:
{
  home.packages = [
    inputs.quickshell.packages.${pkgs.system}.default
    inputs.caelestia-shell.packages.${pkgs.system}.default
    inputs.caelestia-cli.packages.${pkgs.system}.default
  ];

  # Toggle between caelestia (default) and waybar fallback
  home.file.".local/bin/toggle-caelestia.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env sh
      if pgrep -f "quickshell" >/dev/null; then
        pkill -f quickshell
        sleep 0.5
        waybar &
        dunst &
      else
        pkill -x waybar
        pkill -x dunst
        sleep 0.5
        caelestia-shell &
      fi
    '';
  };
}
