# modules/hardware/tuxedo.nix
{ config, pkgs, ... }:

{
  # Enable Tuxedo / Clevo kernel drivers for Gigabyte G5 chassis
  hardware.tuxedo-drivers.enable = true;

  # Enable Tuxedo RS daemon for fan control & power profiles
  hardware.tuxedo-rs = {
    enable = true;
    tailor-gui.enable = true;
  };
}
