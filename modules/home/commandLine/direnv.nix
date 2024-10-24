{ lib, config, ... }:
{
  options.home.direnv = {
    enable = lib.mkEnableOption "direnv";
  };

  config.programs.direnv = lib.mkIf config.home.direnv.enable {
    enable = true;
    nix-direnv.enable = true;
    enableNushellIntegration = config.home.nu.enable;
    enableZshIntegration = config.home.zsh.enable;
  };
}
