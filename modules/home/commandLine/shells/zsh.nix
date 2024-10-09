{lib,config,...}:{
  options.home.zsh = {
    enable = lib.mkEnableOption "zsh";
    nuUtils = lib.mkEnableOption "utils from Nushell like `http`, `ls` and lots of others";
  };

  config = lib.mkIf config.home.zsh.enable {
    programs.zsh = {
      enable = true;
      
      autocd = true;
      defaultKeymap = "viins";

      dirHashes = {
        dev = "$HOME/Developing";
      };
      shellAliases = {
        cat = "bat";
        nixvim = "nix run github:wadsaek/nixvim";
      };
    };
  };
}