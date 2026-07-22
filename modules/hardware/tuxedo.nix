# modules/hardware/tuxedo.nix
{ config, lib, pkgs, ... }:

{
  # Enable Tuxedo / Clevo kernel drivers for Gigabyte G5 chassis
  hardware.tuxedo-drivers.enable = true;

  # Explicitly load Tuxedo kernel modules
  boot.kernelModules = [
    "tuxedo_keyboard"
    "tuxedo_io"
  ];

  # Module parameters for Clevo/Gigabyte keyboard backlight compatibility
  # boot.extraModprobeConfig = ''
  #   options tuxedo_keyboard mode=0 color_left=0xffffff color_center=0xffffff color_right=0xffffff
  # '';

  # Enable Tuxedo RS daemon for fan control & power profiles
  hardware.tuxedo-rs = {
    enable = true;
    tailor-gui.enable = true;
  };

  # Disable tailord background service so it doesn't continuously cycle RGB colors
  # in the background and allows managing keyboard colors directly via hardware keys.
  systemd.services.tailord.enable = lib.mkForce false;

  # Utility to query and control display/keyboard brightness
  environment.systemPackages = with pkgs; [
    brightnessctl
  ];
}
