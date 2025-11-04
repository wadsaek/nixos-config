{ lib, config, ... }:
{
  options = {
    home.ghostty.enable = lib.mkEnableOption "ghostty";
  };

  config.programs.ghostty = lib.mkIf config.home.ghostty.enable {
    enable = true;
  };
}
