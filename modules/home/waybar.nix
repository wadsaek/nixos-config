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
