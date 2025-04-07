{
  lib,
  config,
  pkgs,
  ...
}:
{
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
        exec-once =
          let
            applets = "nm-applet & blueman-applet";
            spotify_player = "$terminal --hold spotify_player";
            fastfetch = "$terminal --hold fastfetch";
          in
          "${applets} & waybar & ${spotify_player} & ${fastfetch}";

        env = [
          "LIBVA_DRIVER_NAME,nvidia"
          "__GLX_VENDOR_LIBRARY_NAME,nvidia"
          "HYPRCURSOR_SIZE,32"
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
        windowrule = [
          "suppressevent maximize, class:.*"
        ];
      } // import ./keybinds.nix { inherit pkgs config lib; };
      extraConfig = ''
        source = /etc/hyprland/monitorSettings
      '';
    };
    home.waybar.enable = lib.mkDefault true;
  };
}
