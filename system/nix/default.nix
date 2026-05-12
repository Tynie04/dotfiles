{ lib, inputs, config, pkgs, ... }:
{
  imports = [ ./nh.nix ];

  environment.systemPackages = [ pkgs.git pkgs.vim pkgs.wget pkgs.curl ];

  nix = {
    # pin the registry to avoid downloading/evaluating a new nixpkgs each time
    registry = lib.mapAttrs (_: v: { flake = v; })
      (lib.filterAttrs (_: v: lib.isType "flake" v) inputs);

    # make nix commands use the pinned registry
    nixPath = lib.mapAttrsToList (key: _: "${key}=flake:${key}") config.nix.registry;

    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      trusted-users = [ "root" "@wheel" ];
    };
  };

  nixpkgs.config.allowUnfree = true;
}
