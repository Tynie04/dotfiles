{ config, pkgs, ... }:
{
  programs.git = {
    enable = true;
    signing = {
      key = "/home/tijnw/.ssh/github.pub";
      signByDefault = true;
    };
    settings = {
      user.name = "Tynie04";
      user.email = "146623061+Tynie04@users.noreply.github.com";
      gpg.format = "ssh";
      init.defaultBranch = "main";
    };
  };
}
