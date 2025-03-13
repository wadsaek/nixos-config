{ lib, config, ... }:
{
  options = {
    home.mediaEditing.enable = lib.mkEnableOption "media editing capabilities";
  };
}
