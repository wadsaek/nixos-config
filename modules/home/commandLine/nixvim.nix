{
  config,
  lib,
  nixvim,
  pkgs,
  ...
}:
{
  options = {
    nixvim.enable = lib.mkEnableOption "my nixvim config";
  };
  config = lib.mkIf config.nixvim.enable {
    home.packages = [
      nixvim.packages.${pkgs.system}.full
    ];
  };
}
