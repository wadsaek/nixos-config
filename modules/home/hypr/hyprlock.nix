{ lib, config, ... }:
lib.mkMerge [
  {
    programs.hyprlock.enable = lib.mkDefault (
      config.home.hypr.enable || config.home.niri.enable
    );
  }
  {
    programs.hyprlock = lib.mkIf config.programs.hyprlock.enable {
      settings = {
        background = lib.mkForce [
          {
            path = "screenshot";
            blur_passes = 3;
            blur_size = 8;
          }
        ];
        label =
          let
            mkLabel =
              attr:
              attr
              // {
                monitor = "";
                font_family = "Aileron";
              };
          in
          lib.map mkLabel [
            {
              position = "0, -80";
              text = "$LAYOUT";
              font_size = 20;
            }
            {
              position = "0, -80";
              text = "$DESC";
              valign = "top";
              font_size = 36;
            }
            {
              position = "0, -160";
              text = "$TIME";
              font_size = 60;
              valign = "top";
            }
          ];
      };
    };
  }
]
