{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # terminal & editors
    neovim
    ripgrep
    unzip
    zip
    btop

    # browser & apps
    firefox
    vscode
    cheese
    obs-studio
    obsidian
    spotify
    discord
    nwg-displays

    # hyprland tools
    polkit_gnome
    grim
    slurp
    wl-clipboard
    brightnessctl
    playerctl
    pamixer
    pavucontrol

    # rice
    rofi
    cliphist
    adwaita-icon-theme
    wlogout
    wl-clipboard

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
