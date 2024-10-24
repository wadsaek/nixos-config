{ lib, config, ... }:
{
  options.display.sddm = {
    enable = lib.mkEnableOption "sddm as the display manager";
  };

  config.services.displayManager.sddm = lib.mkIf config.display.sddm.enable {
    enable = true;
    wayland.enable = true;
  };
}
