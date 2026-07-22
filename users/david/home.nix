# users/david/home.nix
{ config, pkgs, inputs, ... }:

{
  imports = [
    ../../modules/home/bash.nix
    ../../modules/home/antigravity.nix
    ../../modules/home/hyprland.nix
  ];

  home.username = "david";
  home.homeDirectory = "/home/david";
  home.stateVersion = "26.05";
}
