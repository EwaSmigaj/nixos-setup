{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
        url = "github:nixos/nixpkgs/nixos-unstable";
        inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpckgs, ... } @inputs:
  let
    system = "x86_64-linux";
    pkgs = inport nixpkgs {
    inherit system;
    config = {
        allowUnfree = true;
        };
    };

  in {
	nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
	    specialArgs = {inherit system;};
		modules = [
			./nixos/configuration.nix
			inputs.home-manager.nixosModules.default
		];
	};
  };

}