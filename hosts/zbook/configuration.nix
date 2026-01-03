{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/common.nix
    ../../modules/nixos/nh.nix 
    ../../modules/nixos/gaming.nix
  ];

  networking.hostName = "nixos-zbook";

  # Intel Graphics specific 
  nixpkgs.config.packageOverrides = pkgs: {
    intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
  };
  
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  home-manager = {
  useGlobalPkgs = true;
  useUserPackages = true;
  extraSpecialArgs = { inherit inputs; };
  users."ewa" = import ../../modules/home-manager/home.nix;
  };

  # Battery management 
  services.tlp.enable = true; 
}