# modules/home/antigravity.nix
{ config, pkgs, inputs, ... }:

{
  home.packages = [
    inputs.antigravity-nix.packages.${pkgs.system}.google-antigravity-cli
  ];
}
