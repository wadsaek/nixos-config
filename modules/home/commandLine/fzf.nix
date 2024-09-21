{lib,config, ...}:{
  options = {
    home.fzf.enable = lib.mkEnableOption "fzf";
  };

  config.programs.fzf = lib.mkIf config.home.fzf.enable {
    enable = true;
  };
}
