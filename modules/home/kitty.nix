{pkgs, lib, config, ...}:{
  options = {
    home.kitty.enable = lib.mkEnableOption "kitty";
  };
  config = lib.mkIf config.home.kitty.enable{
    programs.kitty = {
      enable = true;
      #font = {
      #  package = pkgs.nerdfonts;
      #  name = "Fira Code";
      #  size = 12;
      #};
      settings = {
        #foreground = "#d4d4d4";
        #background = "#242020";
  
        editor = "nix run github:wadsaek/nixvim";
        notify_on_cmd_finish = "invisible 15.0";
        confirm_os_window_close = 0;
      };
    };
  };
}
