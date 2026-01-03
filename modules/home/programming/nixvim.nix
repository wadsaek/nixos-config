{
  config,
  lib,
  nixvim,
  ...
}:
{
  options = {
    nixvim.enable = lib.mkEnableOption "my nixvim config";
  };
  config = lib.mkIf config.nixvim.enable {
    home.packages = [
      nixvim
    ];
  };
}
