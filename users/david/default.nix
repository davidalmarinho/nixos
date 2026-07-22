# users/david/default.nix
{ config, pkgs, ... }:

{
  services.getty.autologinUser = "david";

  users.users.david = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      tree
    ];
  };
}
