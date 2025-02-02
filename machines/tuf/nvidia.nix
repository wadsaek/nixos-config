{ config, lib, ... }:
{
  boot.extraModprobeConfig = ''
    options nvidia_drm modeset=1 fbdev=1
  '';
  boot.initrd.availableKernelModules = [
    "nvidia"
    "nvidia_modeset"
    "nvidia_uvm"
    "nvidia_drm"
  ];

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    open = false;
    powerManagement.enable = true;
    package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
      version = "570.86.16"; # use new 570 drivers
      sha256_64bit = "sha256-RWPqS7ZUJH9JEAWlfHLGdqrNlavhaR1xMyzs8lJhy9U=";
      openSha256 = "sha256-DuVNA63+pJ8IB7Tw2gM4HbwlOh1bcDg2AN2mbEU9VPE=";
      settingsSha256 = "sha256-9rtqh64TyhDF5fFAYiWl3oDHzKJqyOW3abpcf2iNRT8=";
      usePersistenced = false;
    };
    modesetting.enable = true;
    nvidiaSettings = true;
    prime = {
      sync.enable = true;
      nvidiaBusId = "PCI:100:00:0";
      amdgpuBusId = "PCI:101:00:0";
    };
  };
}
