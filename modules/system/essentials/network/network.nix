{lib, config, ...}:{
  imports = [
    ./wpa_suppl.nix
    ./iwd.nix
  ];

  networking.networkmanager = {
    enable = true;
    unmanaged = lib.mkIf config.network.wpa_suppl.enable ["*" "except:type:wwan" "except:type:gsm"];
    wifi.backend = lib.mkIf config.network.iwd.enable "iwd";
  };
}
