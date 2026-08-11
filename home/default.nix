{ pkgs, ... }:
let
  win10os-cursors = pkgs.stdenvNoCC.mkDerivation {
    pname = "win10os-cursors";
    version = "unstable-2024";
    src = pkgs.fetchFromGitHub {
      owner = "Tynie04";
      repo = "Win10OS-cursors";
      rev = "79d13bb90eb9346a40a2da5a1f5cb24cb919f256";
      hash = "sha256-fwnTC1jZl88orC4sBsMglmMlA2N1SlD/6qT5FBPpL4c=";
    };
    installPhase = ''
      mkdir -p $out/share/icons/Win10OS-Cursors
      cp -r dist/cursors $out/share/icons/Win10OS-Cursors/
      cp dist/index.theme $out/share/icons/Win10OS-Cursors/
    '';
  };
in
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
    package = win10os-cursors;
    name = "Win10OS-Cursors";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  programs.home-manager.enable = true;
}
