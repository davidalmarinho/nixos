{ config, pkgs, inputs, ... }:
{
  home.username = "david";
  home.homeDirectory = "/home/david";
  home.stateVersion = "26.05";

  home.packages = [
    inputs.antigravity-nix.packages.${pkgs.system}.google-antigravity-cli
  ];

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
