{
  description = "tijnw's NixOS flake";

  outputs =
    inputs @ { self, nixpkgs, hm, ... }:
    {
      nixosConfigurations.hermes2 = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs self; };
        modules = [
          ./hosts/hermes2
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
