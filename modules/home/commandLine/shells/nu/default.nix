{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    home.nu.enable = lib.mkEnableOption "NuShell";
  };

  config = lib.mkIf config.home.nu.enable {
    programs.nushell = {
      enable = true;
      configFile.source = ./config.nu;
      envFile.source = ./env.nu;
      shellAliases = {
        cat = lib.mkIf config.home.bat.enable "bat";
        vi = "nvim";
        vim = "nvim";
        nvim-local = "${pkgs.neovim}/bin/nvim";
      };
    };
  };
}
