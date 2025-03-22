{ lib, config, ... }:
{
  config.programs.hyprlock = lib.mkIf config.home.hypr.enable {
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
}
