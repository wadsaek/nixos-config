{lib,config,...}:{
  options = {};
  config = lib.mkIf config.home.waybar.enable{
    programs.waybar = {
      enable = true;
      #settings = {};
      #style = "";
    };
  }; 
}
