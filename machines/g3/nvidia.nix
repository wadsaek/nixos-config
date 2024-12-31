{ config, lib, ... }:
{
  options = {
    graphics.nvidia.enable = lib.mkEnableOption "nvidia configuration";
    graphics.nvidia.prime.enable = lib.mkEnableOption "prime for nvidia";
    graphics.buses =
      let
        busIDType = lib.types.strMatching "([[:print:]]+[\:\@][0-9]{1,3}\:[0-9]{1,2}\:[0-9])?";
      in
      {
        nvidia = lib.mkOption {
          type = busIDType;
          default = "";
          example = "PCI:1:0:0";
          description = ''
            Bus ID of the NVIDIA GPU. You can find it using lspci; for example if lspci
            shows the NVIDIA GPU at "01:00.0", set this option to "PCI:1:0:0".
          '';
        };

        intel = lib.mkOption {
          type = busIDType;
          default = "";
          example = "PCI:0:2:0";
          description = ''
            Bus ID of the Intel GPU. You can find it using lspci; for example if lspci
            shows the Intel GPU at "00:02.0", set this option to "PCI:0:2:0".
          '';
        };

        amd = lib.mkOption {
          type = busIDType;
          default = "";
          example = "PCI:4:0:0";
          description = ''
            Bus ID of the AMD APU. You can find it using lspci; for example if lspci
            shows the AMD APU at "04:00.0", set this option to "PCI:4:0:0".
          '';
        };
      };
  };
  config = lib.mkIf config.graphics.nvidia.enable {
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.nvidia = {
      open = false;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      modesetting.enable = true;
      nvidiaSettings = true;
      prime = lib.mkIf config.graphics.nvidia.prime.enable (
        with config.graphics.buses;
        {
          sync.enable = true;

          intelBusId = intel;

          nvidiaBusId = nvidia;

          amdgpuBusId = amd;
        }
      );
    };
  };
}
