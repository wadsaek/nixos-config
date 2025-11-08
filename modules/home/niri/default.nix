{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.home.niri.enable = lib.mkEnableOption "niri";
  config = lib.mkIf config.home.niri.enable {
    home.file.".config/niri/config.kdl".text = import ./config.nix { inherit lib config pkgs; };
  };
}
