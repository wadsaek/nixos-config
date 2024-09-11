{lib,config,...}:{
  options = {
    nh.enable = lib.mkEnableOption "nh";
  };
  config = lib.mkIf config.nh.enable {
    programs.nh = {
      enable = true;
      flake = ../../..;
    };
  };
}
