{ pkgs, ... }:
{
  systemd.services.greetd.preStart = ''
    for i in 1 2 3 4 5 6; do
      ${pkgs.kbd}/bin/setleds -D +num < /dev/tty$i 2>/dev/null || true
    done
  '';

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --sessions /run/current-system/sw/share/wayland-sessions:/run/current-system/sw/share/xsessions";
        user = "greeter";
      };
    };
  };
}
