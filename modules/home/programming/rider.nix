{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.rider.enable = lib.mkEnableOption "rider";
  config.home.packages = lib.mkIf config.rider.enable [ pkgs.jetbrains.rider ];
}
