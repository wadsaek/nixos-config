{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    home.hypr.enable = lib.mkEnableOption "hypr ecosystem";
  };

  config = lib.mkIf config.home.hypr.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      settings = {
        debug.disable_logs = false;
        #apps for hyprland shortcuts
        "$terminal" = "kitty";
        "$fileManager" = "$terminal ${pkgs.yazi}/bin/yazi";
        "$menu" = "${pkgs.walker}/bin/walker";
        "$screenshotCommand" =
          ''${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp -w 0)" - | ${pkgs.wl-clipboard}/bin/wl-copy '';
        "$screenshotScreen" = ''${pkgs.grim}/bin/grim - | ${pkgs.wl-clipboard}/bin/wl-copy '';

        #autostart
        exec-once = "nm-applet & blueman-applet & waybar & $terminal --hold spotify_player & $terminal --hold fastfetch";

        env = [
          "LIBVA_DRIVER_NAME,nvidia"
          "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        ];
        general = {
          gaps_in = 2;
          gaps_out = 10;

          border_size = 1;

          #"col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
          #"col.inactive_border" = "rgba(595959aa)";

          resize_on_border = true;

          allow_tearing = true;

          layout = "dwindle";
        };

        decoration = {
          rounding = 3;
          active_opacity = 0.95;
          inactive_opacity = 0.8;

          shadow.enabled = true;
          shadow.range = 4;
          shadow.render_power = 3;
          #"col.shadow" = "rgba(1a1a1aee)";

          blur = {
            enabled = true;
            size = 5;
            passes = 2;
            vibrancy = 0.1696;
          };
        };
        animations = {
          enabled = true;
          bezier = [
            "myBezier, 0.05, 0.9, 0.1, 1.05"
          ];
          animation = [
            "windows, 1, 7, myBezier"
            "windowsOut, 1,7, default, popin 80%"
            "border, 1, 10, default"
            "borderangle, 1, 8, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
          ];
        };
        dwindle = {
          pseudotile = true;
          #i probably want this?
          preserve_split = true;
        };
        master = {
          new_status = "master";
        };
        misc = {
          force_default_wallpaper = -2;
          #DO NOT CHANGE
          disable_hyprland_logo = false;
        };
        input = {
          kb_layout = "us, ua, il";
          kb_options = "grp:alt_shift_toggle";

          kb_variant = "";
          kb_model = "";
          kb_rules = "";

          follow_mouse = 1;

          sensitivity = 0; # no modification
          touchpad = {
            natural_scroll = true;
          };
        };
        gestures = {
          workspace_swipe = true;
        };

        "$mainMod" = "SUPER";
        bind =
          [
            "$mainMod, F, fullscreen,"
            "$mainMod, Q, exec, $terminal"
            "$mainMod, C, killactive,"
            "$mainMod SHIFT, End, exit,"
            "$mainMod, E, exec, $fileManager"
            "$mainMod, V, togglefloating,"
            "$mainMod, R, exec, $menu"
            "$mainMod SHIFT, S, exec, $screenshotCommand"
            ",Print, exec, $screenshotScreen"
            "$mainMod, backspace, exec, hyprlock"

            #dwindle
            "$mainMod, P, togglesplit,"

            #the special workspace
            "$mainMod, M, togglespecialworkspace, magic"
            "$mainMod SHIFT, M, movetoworkspace, special:magic"

            "$mainMod, mouse_up, workspace, e-1"
            "$mainMod, mouse_down, workspace, e+1"

          ]
          ++ lib.optionals config.programs.eww.enable [
            "$mainMod SHIFT, delete, exec, eww close-all"
            "$mainMod SHIFT, P, exec, eww open powermenu"
          ]
          ++ (
            # workspaces
            # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
            builtins.concatLists (
              builtins.genList (
                x:
                let
                  ws =
                    let
                      c = (x + 1) / 10;
                    in
                    builtins.toString (x + 1 - (c * 10));
                in
                [
                  "$mainMod, ${ws}, workspace, ${toString (x + 1)}"
                  "$mainMod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
                ]
              ) 10
            )
          )
          ++ (lib.pipe
            {
              H = "l";
              left = "l";
              J = "d";
              down = "d";
              K = "u";
              up = "u";
              L = "r";
              right = "r";
            }
            [
              (lib.attrsets.mapAttrsToList (name: value: { inherit name value; }))
              (builtins.map (
                { name, value }:
                [
                  "$mainMod, ${name}, movefocus, ${value}"
                  "$mainMod SHIFT, ${name}, swapwindow, ${value}"
                ]
              ))
              builtins.concatLists
            ]
          );
        bindm = [
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        ];
        bindel = [
          ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
          ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ", XF86MonBrightnessUp, exec, ${pkgs.brightnessctl}/bin/brightnessctl set 5%+"
          ", XF86MonBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl set 5%-"
        ];
        bindl = [
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ", XF86AudioPlay, exec, playerctl play-pause"
          ", XF86AudioPrev, exec, playerctl previous"
          ", XF86AudioNext, exec, playerctl next"
        ];
        windowrulev2 = [
          "suppressevent maximize, class:.*"
        ];
      };
      extraConfig = ''
        source = /etc/hyprland/monitorSettings
      '';
    };

    programs.hyprlock = {
      enable = true;
      settings = {
        background = lib.mkForce [
          {
            path = toString ../stylix/wallpaper.jpg;
            blur_passes = 3;
            blur_size = 8;
          }
        ];
        #input-field = [
        #  {
        #    size = "200, 50";
        #    position = "0, -80";
        #    fade_on_empty = false;
        #  }
        #];
      };
    };

    services.hypridle = {
      enable = true;
      settings = {
        listener = [
          (
            let
              fade_brightness = pkgs.writeShellApplication {
                name = "fade_brightness";
                runtimeInputs = [ pkgs.brightnessctl ];

                text = ''
                  mkdir -p "/tmp/hypr/$USER";
                  cd "/tmp/hypr/$USER";
                  brightnessctl get > brightness;
                  brightnessctl set 5%;
                '';
              };
              return_brightness = pkgs.writeShellApplication {
                name = "return_brightness";
                runtimeInputs = [
                  pkgs.brightnessctl
                  pkgs.bat
                ];

                text = ''
                  cd "/tmp/hypr/$USER";
                  brightnessctl set "$(bat brightness)";
                  rm brightness;
                '';
              };
            in
            {
              timeout = 300;
              on-timeout = "${fade_brightness}/bin/fade_brightness";
              on-resume = "${return_brightness}/bin/return_brightness";
            }
          )
          {
            timeout = 900;
            on-timeout = "hyprlock";
          }
          {
            timeout = 1800;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
        ];
      };
    };
    home.waybar.enable = lib.mkDefault true;
  };
}
