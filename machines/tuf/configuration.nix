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

  services.supergfxd.enable = true;
  systemd.services.supergfxd.path = [ pkgs.pciutils ];
  services.asusd = {
    enable = true;
    enableUserService = true;
  };
  boot.kernelModules = [
    "asus-wmi"
    "asus-armoury"
  ];

  hostName = "Esther-tuf";
  resolution = {
    vertical = 1080;
    horizontal = 1920;
  };

  display = {
    sddm.enable = true;
    plasma.enable = true;
    hyprland.enable = true;
  };

  postgres.enable = true;
  virtualisation.waydroid.enable = true;
  services.cosmos.enable = true;

  services.hardware.openrgb.enable = true;
  steam.enable = true;
  packages.full = true;

  fonts.full = true;
  environment.etc."hyprland/monitorSettings".text = ''
    monitor = eDP-1,1920x1200@144,auto,1
  '';
}
