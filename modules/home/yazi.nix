{pkgs, lib, config, ...}: {
  options = {
    home.yazi.enable = lib.mkEnableOption "yazi";
  };
  config = lib.mkIf config.home.yazi.enable{  
    programs.yazi = {
      enable = true;
      enableNushellIntegration = lib.mkIf config.home.nu.enable true;
      settings = {
        manager = {
          show_hidden = true;
          sort_dir_first = true;
        };
      };
    };
  };
}
