{pkgs, lib, config, ...}: {
  options = {
    home.starship.enable = lib.mkEnableOption "starship";
  };

  config = lib.mkIf config.home.starship.enable {
    programs.starship = {
      enable = true;
      enableNushellIntegration = lib.mkIf config.home.nu.enable (lib.mkDefault true);
      enableZshIntegration = lib.mkIf config.home.zsh.enable (lib.mkDefault true);
      
    };
  };
}
