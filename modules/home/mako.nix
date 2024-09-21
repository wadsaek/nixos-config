{config, lib, ...}:{
  options.home.mako.enable = lib.mkEnableOption "mako for notifications";

  config.services.mako = lib.mkIf config.home.mako.enable {
    enable = true;
    defaultTimeout = 5000;
    borderRadius = 4;
  };
}
