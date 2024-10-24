{ lib, config, ... }:
{
  imports = [
    ./wpa_suppl.nix
    ./iwd.nix
  ];

  network.iwd.enable = lib.mkDefault true;

  networking.networkmanager = {
    enable = true;
    unmanaged = lib.mkIf config.network.wpa_suppl.enable [
      "*"
      "except:type:wwan"
      "except:type:gsm"
    ];
    wifi.backend = lib.mkIf config.network.iwd.enable "iwd";
  };
}
