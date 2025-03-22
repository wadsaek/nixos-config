{
  pkgs,
  lib,
  config,
  ...
}:
{
  config.services.hypridle = lib.mkIf config.home.hypr.enable {
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
}
