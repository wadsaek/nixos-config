{
  lib,
  config,
  pkgs,
  ...
}:
{
  home.sessionVariables = {
    EDITOR = "nvim";
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "$HOME/.steam/root/compatibilitytools.d";
    QT_QPA_PLATFORM = "wayland";
    XCURSOR_SIZE = lib.mkForce (toString config.stylix.cursor.size);
  };
  programs.nushell.environmentVariables = builtins.mapAttrs (
    name: value:
    let
      maps = {
        HOME = "env.HOME";
      };
      mapsKeys = builtins.attrNames maps;
      mapsValues = lib.attrVals mapsKeys maps;
    in
    builtins.replaceStrings mapsKeys mapsValues value
  ) config.home.sessionVariables;
}
