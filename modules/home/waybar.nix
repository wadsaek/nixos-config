{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    home.waybar.enable = lib.mkEnableOption "waybar";
  };
  config = lib.mkIf config.home.waybar.enable {
    programs.waybar = {
      enable = true;
      # settings =  
      # let
      #   weatherScript = pkgs.writers.writePython3Bin "waybar-weather" { } /*python*/''
      #   print("hello world")
      #   a = 5
      #   '';
      # in {
      # mainBar= {
      #   layer = "top";
      #   position = "top";
      #   mode = "dock";
      #   exclusive = true;
      #   passthrough = false;
      #   gtk-layer-shell = true;
      #   height = 0;
      #   modules-left = [
      #     "clock"
      #     "custom/weather"
      #     "hyprland/workspaces"
      #   ];
      #   modules-center = [
      #     "hyprland/window"
      #   ];
      #   modules-right = [
      #     "tray"
      #     "custom/walker"
      #     "custom/language"
      #     "battery"
      #     "backlight"
      #     "pulseaudio"
      #     "pulseaudio#microphone"
      #   ];
      # };
      # backlight = { device = "intel_backlight"; format = "{icon} {percent}%"; format-icons = [ "󰃞" "󰃟" "󰃠" ]; min-length = 6; on-scroll-down = "brightnessctl set 1%-"; on-scroll-up = "brightnessctl set 1%+"; }; battery = { format = "{icon} {capacity}%"; format-alt = "{time} {icon}"; format-charging = " {capacity}%"; format-icons = [ "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ]; format-plugged = " {capacity}%"; states = { critical = 20; good = 95; warning = 30; }; }; clock = { format = "{:%H:%M}"; tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>"; }; "custom/walker" = { format = "󰐊"; on-click = "walker"; }; "custom/weather" = { exec = "${weatherScript}/bin/waybar-weather"; format = "{}"; interval = 30; return-type = "json"; tooltip = true; }; "hyprland/window" = { format = "{}"; }; "hyprland/workspaces" = { all-outputs = true; disable-scroll = true; on-click = "activate"; persistent-workspaces = { "1" = [ ]; "10" = [ ]; "2" = [ ]; "3" = [ ]; "4" = [ ]; "5" = [ ]; "6" = [ ]; "7" = [ ]; "8" = [ ]; "9" = [ ]; }; }; pulseaudio = { format = "{icon} {volume}%"; format-icons = { car = ""; default = [ "" "" "" ]; hands-free = ""; headphone = ""; headset = ""; phone = ""; portable = ""; }; format-muted = " Muted"; on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"; on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"; on-scroll-up = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"; scroll-step = 5; tooltip = false; }; "pulseaudio#microphone" = { format = "{format_source}"; format-source = "󰍬 {volume}%"; format-source-muted = "󰍭 Muted"; on-click = "pamixer --default-source -t"; on-scroll-down = "pamixer --default-source -d 5"; on-scroll-up = "pamixer --default-source -i 5"; scroll-step = 5; }; tray = { icon-size = 13; spacing = 10; };
      # };
      style =
        let
          inherit (config.lib.stylix.colors.withHashtag)
            base00
            base0A
            base05
            base0E
            base0D
            base0C
            base0B
            base09
            base0F
            base01
            ;
        in
        # css
        ''
                * {
                  border: none;
          	border-radius: 0;
                  min-height: 0;
                }
                window#waybar {
                  background: none;
                }

                tooltip {
                  background: ${base01};
                  border-radius: 10px;
                  border-width: 2px;
                  border-style: solid;
                }

                #workspaces button {
                  padding: 5px;
                  margin-right: 5px;
                }

                #workspaces button.active {
                  color: ${base0A}
                }

                #workspaces button.focused {
                  color: ${base0A};
                  background: ${base05};
                  border-radius: 10px;
                }
                #custom-language,
                #custom-walker,
                #custom-caffeine,
                #custom-weather,
                #window,
                #clock,
                #battery,
                #pulseaudio
                #network,
                #workspaces,
                #tray,
                #backlight {
                  background: ${base00};
                  padding: 0px 10px;
                  margin: 3px 0px;
                  margin-top: 5px;
                  border: 1px solid ${base01};
                }

                #tray {
                  border-radius: 10px;
                  margin-right: 10px;
                }
                #workspaces {
                  background:${base00};
                  border-radius: 10px;
                  margin-left: 10px;
                  padding-right: 0px;
                  padding-left: 5px;
                }

                #custom-caffeine {
                  color: ${base09};
                  border-radius: 10px 0px 0px 10px;
                  border-right: 0px;
                  margin-left: 10px;
                }

                #custom-language {
                  color: ${base0A};
                  border-left:0px;
                  border-right:0px;
                }
                #custom-walker {
                  color: ${base0B};
                  border-left:0px;
                  border-radius: 10px 0px 0px 10px;
                  border-right: 0px;
                }

                #window {
                  border-radius: 10px;
                  margin-left: 60px;
                  margin-right: 60px;
                }

                #clock {
                  color: ${base0C};
                  border-radius: 10px 0px 0px 10px;
                  margin-left: 5px;
                  border-right: 0px;
                }

                #network {
                  color: ${base0D};
                }

                #pulseaudio {
                  color: ${base0E};
                  border-left: 0px;
                  border-right: 0px;
                }

                #pulseaudio.microphone {
                  color: ${base0E};
                  border-radius: 0px 10px 10px 0px;
                  border-left: 0px;
                  border-right: 0px;
                  margin-right: 5px;
                }

                #battery {
                  color: ${base0F};
                  border-radius: 0px 10px 10px 0px;
                  margin-right: 10px;
                  border-left: 0px;
                }
                
                #custom-weather {
                  border-radius: 0px 10px 10px 0px;
                  border-right: 0px;
                  margin-left: 0px;
                }
        '';
    };
  };
}
