{ config, pkgs, ... }:

{
  home.username = "ewa";
  home.homeDirectory = "/home/ewa";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    wget
    git
    chromium
    discord
    telegram-desktop
    notepad-next
    vscodium
    python314
    kitty
    mpv
    typst
    nix-top
    zsh
  ];

  programs.git = {
    enable = true;
    userName = "EwaSmigaj";
    userEmail = "ewa.smigaj1@gmail.com";
    extraConfig.init.defaultBranch = "main";
  };

  home.shellAliases = {
  rebuild-pc = "sudo nixos-rebuild switch --flake .#nixos-pc";
  rebuild-laptop = "sudo nixos-rebuild switch --flake .#nixos-laptop";
};
}