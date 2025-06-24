{ config, lib, ... }:
{
  options.steam.enable = lib.mkEnableOption "steam";
  config = lib.mkIf config.steam.enable {
    services.flatpak.enable = true;
    programs = {
      steam = {
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
