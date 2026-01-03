{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/common.nix
    ../../modules/nixos/gaming.nix
    ../../modules/nixos/nvidia.nix
    ../../modules/nixos/nh.nix
  ];

  networking.hostName = "nixos-pc";

  # Mouse fixes (Specific to PC/Gaming mouse)
  boot.kernelParams = [ "usbcore.autosuspend=-1" ];
  services.libinput.mouse.accelProfile = "flat";
  services.libinput.mouse.accelSpeed = "0";
  
  boot.extraModprobeConfig = ''options bluetooth disable_ertm=1'';

  # CUDA & High-performance settings
  nixpkgs.config.cudaSupport = true;
  nix.settings = {
    substituters = [ "https://nix-community.cachix.org" ];
    trusted-public-keys = [ "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" ];
  };

  home-manager = {
  useGlobalPkgs = true;
  useUserPackages = true;
  extraSpecialArgs = { inherit inputs; };
  users."ewa" = import ../../modules/home-manager/home-pc.nix;
  };

  facter.reportPath = ./facter.json;
}