{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
       url = "github:nix-community/home-manager";
       inputs.nixpkgs.follows = "nixpkgs";
     };

    nixos-facter-modules.url = "github:numtide/nixos-facter-modules";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    # use "nixos", or your hostname as the name of the configuration
    # it's a better practice than "default" shown in the video
    # nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
    #   specialArgs = {inherit inputs;};
    #   modules = [
    #     ./hosts/default/configuration.nix
        #  inputs.home-manager.nixosModules.default
        #  inputs.nixos-facter-modules.nixosModules.facter 
    #   ];
    # };
    nixosConfigurations = {
      # This name must match the command you run or your hostname
      nixos-pc = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [ 
          ./hosts/pc/configuration.nix 
          inputs.home-manager.nixosModules.default
          inputs.nixos-facter-modules.nixosModules.facter 
        ];
      };

      nixos-zbook = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [ 
          ./hosts/zbook/configuration.nix
          inputs.home-manager.nixosModules.default
          inputs.nixos-facter-modules.nixosModules.facter 
        ];
      };
    };
  };
}
