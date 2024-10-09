{lib,config,...}:{
  options.home.tmux = {
    enable = lib.mkEnableOption "tmux";
  };

  config.programs.tmux = lib.mkIf config.home.tmux.enable {
    enable = true;
    clock24 = true;
    keyMode = "vi";
    terminal = "tmux-kitty";
  };
}
