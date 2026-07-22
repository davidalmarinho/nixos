# modules/core/common.nix
{ config, lib, pkgs, ... }:

{
  # Bootloader setup
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # NetworkManager
  networking.networkmanager.enable = true;

  # Time zone
  time.timeZone = "Europe/Lisbon";

  # Firefox
  programs.firefox.enable = true;

  # Base system packages
  environment.systemPackages = with pkgs; [
    vim
    wget
    foot
    kitty
    waybar
    git
    hyprpaper
  ];

  # Nix daemon settings & experimental features
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };

  # Automatic Nix store garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  system.stateVersion = "26.05";
}
