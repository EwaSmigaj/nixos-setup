{ config, pkgs, inputs, ... }:

{
  # Core Nix Settings
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
  };

  nixpkgs.config.allowUnfree = true;

  # Boot & Kernel
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Localization
  time.timeZone = "Europe/Warsaw";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pl_PL.UTF-8"; LC_IDENTIFICATION = "pl_PL.UTF-8";
    LC_MEASUREMENT = "pl_PL.UTF-8"; LC_MONETARY = "pl_PL.UTF-8";
    LC_NAME = "pl_PL.UTF-8"; LC_NUMERIC = "pl_PL.UTF-8";
    LC_PAPER = "pl_PL.UTF-8"; LC_TELEPHONE = "pl_PL.UTF-8";
    LC_TIME = "pl_PL.UTF-8";
  };

  # Desktop Environment (Shared)
  services.xserver.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.plasma6.enable = true;
  services.xserver.xkb = { layout = "pl"; variant = ""; };
  console.keyMap = "pl2";

  # Sound
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # Networking
  networking.networkmanager.enable = true;

  # Users & Home Manager
  users.users.ewa = {
    isNormalUser = true;
    description = "Ewa";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  services.displayManager.autoLogin = {
    enable = true;
    user = "ewa";
  };

  # Fonts & Basic Programs
  programs.git.enable = true;
  fonts.packages = with pkgs; [
    noto-fonts noto-fonts-cjk-sans noto-fonts-color-emoji
    fira-code fira-code-symbols liberation_ttf
  ];

  system.stateVersion = "25.05";
}