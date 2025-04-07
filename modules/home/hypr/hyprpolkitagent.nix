{ lib, config, ... }:
{
  config.services.hyprpolkitagent = lib.mkIf config.home.hypr.enable {
    enable = true;
  };
}
