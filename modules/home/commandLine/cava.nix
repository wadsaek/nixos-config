{ lib, config, ... }:
{
  opitons.cava.enable = lib.mkEnableOption "cava";
  config.programs.cava = {
    inherit (config.cava) enable;
  };
}
