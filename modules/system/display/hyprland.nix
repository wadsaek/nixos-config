{ lib, config, ... }:
{
  options.display.hyprland = {
    enable = lib.mkEnableOption "hyprland";
  };

  config.programs.hyprland = lib.mkIf config.display.hyprland.enable {
    withUWSM = true;
    enable = true;
  };
}
