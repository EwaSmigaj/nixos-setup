{ config, pkgs, ... }:

{
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 15d --keep 5";
    flake = "/home/ewa/mysystem"; # sets NH_OS_FLAKE variable for you
  };
}