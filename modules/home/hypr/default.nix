{ lib, ... }:
{
  options = {
    home.hypr.enable = lib.mkEnableOption "hypr ecosystem";
  };
  imports = [
    ./hyprland
    ./hypridle.nix
    ./hyprlock.nix
  ];
}
