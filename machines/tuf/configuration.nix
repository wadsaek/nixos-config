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
  # boot.kernelPatches =
  #   let
  #     patchRepo = pkgs.fetchFromGitHub {
  #       owner = "uejji";
  #       repo = "asus-armoury";
  #       rev = "f55509ee18bb1195eb7cbd93b40331901d230de6";
  #       hash = "sha256-/csCSdZ6JH68Prr0JpED4SRrirS3xyXupuigfVil6nE=";
  #     };
  #     patchDir = "${patchRepo}/patch";
  #   in
  #   [
  #     {
  #       name = "move existsing tunings to a";
  #       patch = "${patchDir}/01-platform-x86-asus-armoury-move-existing-tunings-to-a.patch";
  #     }
  #     {
  #       name = "add-dgpu-tgp-control";
  #       patch = "${patchDir}/02-platform-x86-asus-armoury-add-dgpu-tgp-control.patch";
  #     }
  #     {
  #       name = "add-apu-mem-control-suppor";
  #       patch = "${patchDir}/03-platform-x86-asus-armoury-add-apu-mem-control-suppor.patch";
  #     }
  #     {
  #       name = "add-core-count-control";
  #       patch = "${patchDir}/04-platform-x86-asus-armoury-add-core-count-control.patch";
  #     }
  #   ];

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
