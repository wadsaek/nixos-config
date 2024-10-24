{ pkgs, lib, ... }@inputs:
{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/system/configuration.nix
  ];

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
}
