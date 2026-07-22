# /etc/nixos/configuration.nix
#
# Standalone NixOS configuration wrapper for legacy `nixos-rebuild` compatibility.
# For flake-based rebuilds, run:
#   sudo nixos-rebuild switch --flake .#gigabyte-g5kf

{ config, pkgs, ... }:

{
  imports = [
    ./hosts/gigabyte-g5kf
  ];
}
