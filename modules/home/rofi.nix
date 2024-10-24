{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    home.rofi.enable = lib.mkEnableOption "rofi";
  };

  config.programs.rofi = lib.mkIf config.home.rofi.enable {
    enable = true;
    package = pkgs.rofi-wayland;
  };
}
