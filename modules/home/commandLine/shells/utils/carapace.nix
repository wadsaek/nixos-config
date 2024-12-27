{ lib, config, ... }:
{
  programs.carapace = {
    enable = lib.mkDefault config.home.nu.enable;
    enableZshIntegration = lib.mkDefault false;

  };
}
