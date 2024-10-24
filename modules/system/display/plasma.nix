{ lib, config, ... }:
{
  options.display.plasma = {
    enable = lib.mkEnableOption "plasma";
  };

  config.services.desktopManager.plasma6 = lib.mkIf config.display.plasma.enable {
    enable = true;
  };
}
