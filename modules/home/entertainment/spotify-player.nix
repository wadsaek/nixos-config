{lib, config,...}:{
  options = {
    home.spotify-player.enable = lib.mkEnableOption "spotify player";
  };

  config.programs.spotify-player = lib.mkIf config.home.spotify-player.enable {
    enable = true;
  };
}
