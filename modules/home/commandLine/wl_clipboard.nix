{lib, pkgs, config, ...}: {
  options = {
    home.wl_clipboard.enable = lib.mkEnableOption "wl_clipboard";
  };

  config = lib.mkIf config.home.wl_clipboard.enable {
    home.packages = [pkgs.wl_clipboard];
  };
}
