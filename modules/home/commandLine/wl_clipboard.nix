{lib, pkgs, config, ...}: {
  options = {
    home.wl-clipboard.enable = lib.mkEnableOption "wl_clipboard";
  };

  config = lib.mkIf config.home.wl-clipboard.enable {
    home.packages = [pkgs.wl-clipboard];
  };
}
