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
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    modesetting.enable = true;
    nvidiaSettings = true;
    prime = {
      sync.enable = true;
      nvidiaBusId = "PCI:100:00:0";
      amdgpuBusId = "PCI:101:00:0";
    };
  };
}
