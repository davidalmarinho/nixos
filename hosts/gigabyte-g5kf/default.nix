# hosts/gigabyte-g5kf/default.nix
{ config, pkgs, ... }:

{
  imports = [
    ../../modules/core/common.nix
    ../../modules/desktop/hyprland.nix
    ../../modules/hardware/nvidia.nix
    ../../users/david
    ./hardware-configuration.nix
  ];

  networking.hostName = "gigabyte-g5kf";
}
