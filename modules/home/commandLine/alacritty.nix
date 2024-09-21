{lib,config,...}:{
  options = {
    home.alacritty.enable = lib.mkEnableOption "alacritty";
  };

  config.programs.alacritty = lib.mkIf config.home.alacritty.enable  {
    enable = true;
  };
}
