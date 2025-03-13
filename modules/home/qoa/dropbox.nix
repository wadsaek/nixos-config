{
  config,
  lib,
  pkgs,
  ...
}:
let
  isEnabled = config.services.dropbox.enable;
in
{
  services.dropbox.path = lib.mkIf isEnabled (
    lib.mkDefault "${config.home.homeDirectory}/Documents/Dropbox"
  );
  home.packages = lib.mkIf isEnabled [
    # pkgs.dropbox
  ];
}
