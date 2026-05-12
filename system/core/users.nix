{ pkgs, ... }:
{
  users.users.tijnw = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "audio" "input" ];
    initialPassword = "changeme";
    shell = pkgs.fish;
  };
}
