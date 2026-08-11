{ pkgs, ... }:
{
  users.users.tijnw = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "audio" "input" "docker" ];
    initialPassword = "changeme";
    shell = pkgs.fish;
  };
}
