{pkgs, lib, config, ...}: {
  options = {
    home.starship.enable = lib.mkEnableOption "starship";
    home.starship.enableNushellIntegration = lib.mkEnableOption "nushell integration for starship";
  };

  config = lib.mkIf config.home.starship.enable {
    programs.starship = {
      enable = true;
      enableNushellIntegration = lib.mkIf config.home.nu.enable true;
    };
  };
}
