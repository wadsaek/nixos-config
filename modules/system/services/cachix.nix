{ lib, config }:
{
  options.cachix.enable = lib.mkEnableOption "cachix";

  config.services.cachix = lib.mkIf config.cachix.enable {

  };
}
