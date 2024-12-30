{ pkgs, lib, ... }@inputs:
{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/system/configuration.nix
    ./../../modules/stylix/nixos.nix
  ];
  hostName = "Esther-g3";
  resolution = {
    vertical = 1080;
    horizontal = 1920;
  };

  graphics.nvidia = {
    enable = true;
    prime.enable = true;
  };

  display = {
    sddm.enable = true;
    plasma.enable = true;
    hyprland.enable = true;
  };

  postgres.enable = true;
  virtualisation.waydroid.enable = true;
  services.cosmos.enable = true;
  kmscon.enable = true;
}
