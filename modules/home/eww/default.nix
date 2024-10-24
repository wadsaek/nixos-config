{ config, ... }:
{
  programs.eww = {
    enable = true;
    configDir = ./config;
    enableZshIntegration = config.home.zsh.enable;
  };
}
