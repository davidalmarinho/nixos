# modules/home/bash.nix
{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;
    shellAliases = {
      btw = "echo i use hyprland btw";
    };
    profileExtra = ''
      if uwsm check may-start && [ "$XDG_VTNR" = 1 ]; then
        exec uwsm start hyprland.desktop
      fi
    '';
  };
}
