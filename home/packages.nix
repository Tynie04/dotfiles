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

    # hyprland
    hyprlock
    hypridle
    polkit_gnome
    grim
    slurp
    wl-clipboard
    brightnessctl
    playerctl
    pamixer
    pavucontrol

    # rice
    waybar
    rofi
    hyprpaper
    dunst
    libnotify
    wlogout
    copyq
    adwaita-icon-theme
    starship

    # network
    networkmanagerapplet
    blueman

    # coding
    claude-code
    python3
    uv
    go
  ];
}
