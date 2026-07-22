# hosts/gigabyte-g5kf/default.nix
{ config, pkgs, ... }:

{
  imports = [
    ../../modules/common.nix
    ../../modules/hyprland.nix
    ../../modules/nvidia.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "gigabyte-g5kf";
}
