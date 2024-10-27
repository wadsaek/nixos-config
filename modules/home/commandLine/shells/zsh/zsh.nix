{ lib, config, ... }:
{
  options.home.zsh = {
    enable = lib.mkEnableOption "zsh";
    nuUtils = lib.mkEnableOption "utils from Nushell like `http`, `ls` and lots of others";
  };

  config = lib.mkIf config.home.zsh.enable {
    programs.zsh = {
      enable = true;
      initExtra = (builtins.readFile ./.zshrc);

      autocd = true;
      defaultKeymap = "viins";
      autosuggestion.enable = true;
      autosuggestion.highlight = "fg=#aaaaaa";
      syntaxHighlighting.enable = true;
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
