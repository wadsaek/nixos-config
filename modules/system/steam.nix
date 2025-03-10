{ config, lib, ... }:
{
  options.steam.enable = lib.mkEnableOption "steam";
  config = {
    programs = {
      steam = lib.mkIf config.steam.enable {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
        gamescopeSession.enable = true;
      };
      gamemode.enable = true;
      gamescope = {
        enable = true;
        capSysNice = true;
      };
    };
  };
}
