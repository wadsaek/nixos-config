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

  services.postgresql.enable = true;

  environment.etc."hyprland/monitorConfiguration".text = ''
    eDP-1, 1920x1080@60,auto, 1
  '';
}
