{lib, config,...}:{
  options = {
    network.iwd.enable = lib.mkEnableOption "iwd";
  };
  config.networking.wireless.iwd = lib.mkIf config.network.iwd.enable {
    enable = true;
    settings = {
      IPv6 = {
        Enabled = true;
      };
      Settings = {
        AutoConnect = true;
      };
    };
  };
}
