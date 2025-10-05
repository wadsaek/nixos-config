{
  pkgs,
  config,
  lib,
}:
let
  switchKanataText = builtins.readFile ./scripts/kanata.py;
  switchKanata = toString (
    pkgs.writers.writePython3 "waybar-wttr-py" {
    } switchKanataText
  );
in
{
  bind =
    [
      "$mainMod, F, fullscreen,"
      "$mainMod, Q, exec, kitty --hold fastfetch"
      "$mainMod, C, killactive,"
      "$mainMod SHIFT, End, exit,"
      "$mainMod, V, togglefloating,"
      "$mainMod, R, exec, $menu"
      "$mainMod SHIFT, S, exec, $screenshotCommand"
      ",Print, exec, $screenshotScreen"
      "$mainMod, backspace, exec, hyprlock"
      "$mainMod SHIFT, K, exec, ${switchKanata}"

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
}
