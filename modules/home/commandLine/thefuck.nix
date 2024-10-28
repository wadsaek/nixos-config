{config,lib,...}:{
  
  config = {
    programs.thefuck = {
      enable = lib.mkDefault true;
      enableZshIntegration = config.home.zsh.theFuck;
    };
  };
}
