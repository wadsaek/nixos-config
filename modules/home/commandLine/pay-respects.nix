{ config, lib, ... }:
{

  config = {
    programs.pay-respects = {
      enable = lib.mkDefault true;
      enableZshIntegration = config.home.zsh.pay-respects;
    };
  };
}
