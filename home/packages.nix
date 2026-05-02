{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # terminal & editors
    kitty
    neovim
    ripgrep
    unzip
    zip
    btop

    # browser & apps
    firefox
    vscode
    xfce.thunar
    cheese
    obs-studio

    # hyprland ecosystem
    waybar
    rofi
    hyprlock
    pavucontrol
    wlogout
    copyq
    dunst
    hyprpaper
    grim
    slurp
    wl-clipboard
    brightnessctl
    playerctl
    pamixer
    polkit_gnome
    adwaita-icon-theme

    # network
    networkmanagerapplet

    # coding
    claude-code
    python3
    uv
  ];
}
