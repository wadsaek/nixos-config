{lib,config,...}:{
  options = {
    home.waybar.enable = lib.mkEnableOption "waybar";
  };
  config = lib.mkIf config.home.waybar.enable{
    programs.waybar = {
      enable = true;
      #settings = {};
      #style = "";
    };
  }; 
}
