{
  lib,
  config,
  ...
}:
{
  options = {
    home.kitty.enable = lib.mkEnableOption "kitty";
  };
  config = lib.mkIf config.home.kitty.enable {
    programs.kitty = {
      enable = true;
      settings = {
        editor = "nix run github:wadsaek/nixvim";
        notify_on_cmd_finish = "invisible 15.0";
        confirm_os_window_close = -1;
        font_features = "FiraCodeNF-Reg +ss05 +ss03 cv30=1 +ss09";
      };
    };
  };
}
