{
    nvidia= {
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      modesetting.enable = true;
      prime = {
        sync.enable = true;

        #intel integrated
        intelBusId = "PCI:0:2:0";

        #nvidia dedicated
        nvidiaBusId = "PCI:1:0:0";
      };
    };
}
