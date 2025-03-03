{
  lib,
  config,
  ...
}:
{
  options = {
    home.kitty.enable = lib.mkEnableOption "kitty";
  };
  config = lib.mkIf config.home.kitty.enable {
    programs.kitty = {
      enable = true;
      settings =
        let
          colors = config.lib.stylix.colors.withHashtag;
        in
        {
          editor = "nix run github:wadsaek/nixvim";
          notify_on_cmd_finish = "invisible 15.0";
          confirm_os_window_close = -1;

          font_family = "FiraCode Nerd Font";
          font_size = "12";
          font_features = "FiraCodeNF-Reg +ss05 +ss03 cv30=1 +ss09";

          cursor_trail = 150;

          background = colors.base00;
          foreground = colors.base05;

          selection_background = colors.base05;
          selection_foreground = colors.base00;
          url_color = colors.base04;
          cursor = colors.base05;
          active_border_color = colors.base03;
          inactive_border_color = colors.base01;
          active_tab_background = colors.base00;
          active_tab_foreground = colors.base05;
          inactive_tab_background = colors.base01;
          inactive_tab_foreground = colors.base04;
          tab_bar_background = colors.base01;
          wayland_titlebar_color = colors.base00;
          macos_titlebar_color = colors.base00;

          # normal
          color0 = colors.base00;
          color1 = colors.base08;
          color2 = colors.base0B;
          color3 = colors.base0A;
          color4 = colors.base0D;
          color5 = colors.base0E;
          color6 = colors.base0C;
          color7 = colors.base05;

          # bright
          color8 = colors.base03;
          color9 = colors.base09;
          color10 = colors.base06;
          color11 = colors.base02;
          color12 = colors.base04;
          color13 = colors.base05;
          color14 = colors.base07;
          color15 = colors.base07;
        };
    };
  };
}
