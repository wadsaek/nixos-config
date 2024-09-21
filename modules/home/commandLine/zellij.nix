{lib,config, ...}:{
  options = {
    home.zellij.enable = lib.mkEnableOption "zellij";
  };

  config = lib.mkIf config.home.zellij.enable {
    programs.zellij.enable = true;
  };
}
