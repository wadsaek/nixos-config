{ pkgs, lib, config, ... }:
{
  options.display.niri = {
    enable = lib.mkEnableOption "niri";
  };

  config = lib.mkIf config.display.niri.enable {
    environment.systemPackages = [
    pkgs.xwayland-satellite
    ];
    programs.niri.enable = true;
  };
}
