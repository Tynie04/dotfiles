{
  description = "tijnw's NixOS flake";

  outputs =
    inputs @ { self, nixpkgs, hm, ... }:
    let
      hostName = "hermes2";
    in
    {
      nixosConfigurations.${hostName} = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs self hostName; };
        modules = [
          ./hosts/hermes2
          { networking.hostName = hostName; }
          {
            home-manager = {
              users.tijnw.imports = [ ./home ./hosts/hermes2/home.nix ];
              extraSpecialArgs = { inherit inputs self; };
            };
          }
        ];
      };
    };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    hm = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
