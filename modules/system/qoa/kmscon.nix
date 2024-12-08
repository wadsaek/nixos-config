{lib,config,...}:{
  options.kmscon.enable = lib.mkEnableOption "kmscon";
  config.services.kmscon = lib.mkIf config.kmscon.enable {
    enable = true;
  };
}
