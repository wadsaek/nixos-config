{ config, lib, ... }:
{
  options.home.mako.enable = lib.mkEnableOption "mako for notifications";

  config.services.mako = lib.mkIf config.home.mako.enable {
    enable = true;
    settings = {
      default-timeout = 5000;
      border-radius = 4;
    };
  };
}
