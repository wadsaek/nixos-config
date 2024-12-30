{ pkgs, lib, ... }@inputs:
{
  imports = [
    ./hardware-configuration.nix
    ./nvidia.nix
    ./../../modules/system/configuration.nix
    ./../../modules/stylix/nixos.nix
  ];

  # workaround
  services.logrotate.checkConfig = false;

  hostName = "Esther-tuf";
  resolution = {
    vertical = 1080;
    horizontal = 1920;
  };

  hardware.nvidia = lib.mkForce {
    powerManagement.enable = true;
  };

  display = {
    sddm.enable = true;
    plasma.enable = true;
    hyprland.enable = true;
  };

  postgres.enable = true;
  virtualisation.waydroid.enable = true;
  services.cosmos.enable = true;
  # kmscon.enable = true;
}
