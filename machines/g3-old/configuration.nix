{ pkgs, lib, ... }@inputs:
{
  imports = [
    # ./nvidia.nix
    ./hardware-configuration.nix
    ./../../modules/system/configuration.nix
    ./../../modules/stylix/nixos.nix
  ];
  hostName = "Esther-g3";
  resolution = {
    vertical = 1080;
    horizontal = 1920;
  };

  display = {
    hyprland.enable = true;
  };
  packages.graphical = true;

  postgres.enable = true;

  services.logind.lidSwitch = "ignore";
  environment.etc."hyprland/monitorSettings".text = ''
    monitor = eDP-1, 1920x1080@60,auto, 1
  '';
}
