{lib,config, ...}:{
   options = {
     network.wpa_suppl.enable = lib.mkEnableOption "wpa supplicant";
   };
   config = lib.mkIf config.network.wpa_suppl.enable {
    networking.wireless.enable = true;
  };
}
