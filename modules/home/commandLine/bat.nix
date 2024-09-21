{lib,config, ...}:{
  options = {
    home.bat.enable = lib.mkEnableOption "bat";
  };

  config.programs.bat = lib.mkIf config.home.bat.enable {
    enable = true;
  };
}
