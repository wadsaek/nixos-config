{ pkgs, lib, ... }@inputs:
{
  imports = [
    ./nvidia.nix
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
  graphics.buses = {
    intel = "PCI:0:2:0";
    nvidia = "PCI:1:0:0";
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

  environment.etc."hyprland/monitorConfiguration".text = ''
    eDP-1, 1920x1080@60,auto, 1
  '';
}
