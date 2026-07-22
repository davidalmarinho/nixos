# modules/home/hyprland.nix
{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      input = {
        kb_options = "ctrl:nocaps";
        touchpad = {
          natural_scroll = true;
        };
      };
    };
  };
}
