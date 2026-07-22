# modules/home/hyprland.nix
{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    kitty
    nautilus
    wofi
    brightnessctl
    wireplumber
    playerctl
    hyprshot
    hyprsunset
    hyprpaper
    waybar
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";

    settings = {
      monitor = [
        {
          output = "eDP-1";
          mode = "1920x1080@60";
          position = "auto";
          scale = 1.0;
        }
      ];

      config = {
        xwayland = {
          force_zero_scaling = true;
        };

        general = {
          gaps_in = 2;
          gaps_out = 0;
          border_size = 0;
          "col.active_border" = {
            colors = [ "rgba(33ccffee)" "rgba(00ff99ee)" ];
            angle = 45;
          };
          "col.inactive_border" = "rgba(595959aa)";
          resize_on_border = false;
          allow_tearing = false;
          layout = "dwindle";
        };

        decoration = {
          rounding = 10;
          rounding_power = 2;
          active_opacity = 1.0;
          inactive_opacity = 1.0;
          shadow = {
            enabled = true;
            range = 4;
            render_power = 3;
            color = "rgba(1a1a1aee)";
          };
          blur = {
            enabled = true;
            size = 3;
            passes = 1;
            vibrancy = 0.1696;
          };
        };

        dwindle = {
          preserve_split = true;
        };

        master = {
          new_status = "master";
        };

        misc = {
          force_default_wallpaper = 0;
          disable_hyprland_logo = true;
        };

        input = {
          kb_layout = "us,pt";
          kb_options = "ctrl:nocaps,grp:win_space_toggle";
          follow_mouse = 1;
          sensitivity = 0;
          touchpad = {
            natural_scroll = true;
          };
        };
      };
    };

    extraConfig = ''
      local mainMod = "SUPER"
      local terminal = "kitty"
      local fileManager = "nautilus"
      local menu = "wofi --show drun"

      -- Main App Binds
      hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
      hl.bind(mainMod .. " + C", hl.dsp.window.close())
      hl.bind(mainMod .. " + M", hl.dsp.exit())
      hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
      hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
      hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
      hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
      hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))
      hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }))
      hl.bind(mainMod .. " + F9", hl.dsp.exec_cmd("sh " .. os.getenv("HOME") .. "/scripts/bt-toggle.sh"))
      hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("sh " .. os.getenv("HOME") .. "/scripts/toggle-waybar.sh"))

      -- Navigation (Arrow keys)
      hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
      hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
      hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
      hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

      -- Workspaces 1-10
      for i = 1, 10 do
          local key = i % 10
          hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
          hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
      end

      -- Special workspace (scratchpad)
      hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
      hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

      -- Workspace scrolling
      hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
      hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

      -- Mouse window controls
      hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
      hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

      -- Hardware volume and brightness keys
      hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
      hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
      hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
      hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
      hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("${pkgs.brightnessctl}/bin/brightnessctl s 10%+"), { locked = true, repeating = true })
      hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("${pkgs.brightnessctl}/bin/brightnessctl s 10%-"), { locked = true, repeating = true })
      hl.bind("XF86KbdBrightnessUp",  hl.dsp.exec_cmd("${pkgs.brightnessctl}/bin/brightnessctl --device='rgb:kbd_backlight' s 20%+"), { locked = true, repeating = true })
      hl.bind("XF86KbdBrightnessDown",hl.dsp.exec_cmd("${pkgs.brightnessctl}/bin/brightnessctl --device='rgb:kbd_backlight' s 20%-"), { locked = true, repeating = true })

      -- Media key controls
      hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("${pkgs.playerctl}/bin/playerctl next"),       { locked = true })
      hl.bind("XF86AudioPause", hl.dsp.exec_cmd("${pkgs.playerctl}/bin/playerctl play-pause"), { locked = true })
      hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("${pkgs.playerctl}/bin/playerctl play-pause"), { locked = true })
      hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("${pkgs.playerctl}/bin/playerctl previous"),   { locked = true })

      -- Screenshots
      hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd("${pkgs.hyprshot}/bin/hyprshot -m window -m active"))
      hl.bind("PRINT",               hl.dsp.exec_cmd("${pkgs.hyprshot}/bin/hyprshot -m output"))
      hl.bind("SHIFT + PRINT",       hl.dsp.exec_cmd("${pkgs.hyprshot}/bin/hyprshot -m region"))

      -- Gestures & Devices
      hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
      hl.device({ name = "epic-mouse-v1", sensitivity = -0.5 })

      -- Autostart
      hl.on("hyprland.start", function()
        hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'")
        hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'")
        hl.exec_cmd("sh " .. os.getenv("HOME") .. "/scripts/toggle-waybar.sh")
        hl.exec_cmd("${pkgs.hyprsunset}/bin/hyprsunset")
        hl.exec_cmd("sh " .. os.getenv("HOME") .. "/scripts/hyprpaper.sh")
      end)
    '';
  };
}
