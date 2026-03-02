{ lib, config }:
{
  config.boot.plymouth = lib.mkIf config.boot.plymouth.enable {
  };
}
