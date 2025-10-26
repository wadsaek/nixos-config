{
  lib,
  config,
  pkgs,
  ...
}:
let
  home = config.home.homeDirectory;
in
{
  home.sessionVariables = {
    NOTES = "${home}/Documents/obsidian";
    EDITOR = "nvim";
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "${home}/.steam/root/compatibilitytools.d";
    QT_QPA_PLATFORM = "wayland";
    XCURSOR_SIZE = lib.mkForce (toString config.stylix.cursor.size);
  };
  programs.nushell.environmentVariables = (
    lib.attrsets.filterAttrs (n: v: n != "XDG_CONFIG_DIRS") config.home.sessionVariables
  );
}
