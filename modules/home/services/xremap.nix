{
  lib,
  config,
  inputs,
  ...
}:
let
  fingers = [
    "index"
    "middle"
    "ring"
    "pinky"
  ];
in
{
  imports = [
    inputs.xremap-flake.homeManagerModules.default
  ];
  options.services.xremap = {
    homeRowMods.enable = lib.mkEnableOption "home row mods";
    homeRowMods.keybinds =
      let
        inherit (lib) types;
        finger = types.enum fingers;
        mkFingerOption =
          default: name:
          lib.mkOption {
            type = finger;
            description = "which finget to put ${name} on";
            inherit default;
          };
      in
      {
        leftShift = mkFingerOption "index" "shift";
        leftCtrl = mkFingerOption "middle" "ctrl";
        leftMeta = mkFingerOption "ring" "Meta";
        leftAlt = mkFingerOption "pinky" "alt";
      };
  };
  config.services.xremap = lib.mkIf config.services.xremap.enable (
    let
      cfg = config.services.xremap;
      fingerToKeys = {
        index = [
          "f"
          "j"
        ];
        middle = [
          "d"
          "k"
        ];
        ring = [
          "s"
          "l"
        ];
        pinky = [
          "a"
          "semicolon"
        ];
      };
      homeRowModsRemaps =
        let
          fingerToMod = (
            builtins.listToAttrs (
              builtins.map (
                { name, value }:
                {
                  name = value;
                  value = name;
                }
              ) (lib.attrsets.mapAttrsToList lib.attrsets.nameValuePair cfg.homeRowMods.keybinds)
            )
          );
          remap = lib.mkMerge (
            lib.lists.flatten (
              builtins.map (
                finger:
                (builtins.map (key: {
                  ${key} = {
                    alone = key;
                    held = fingerToMod.${finger};
                    alone_timeout_milis = 20;
                  };
                }) fingerToKeys.${finger})
              ) fingers
            )
          );
        in
        remap;
      uniqueness =
        let
          mods = (
            builtins.map (as: as.value) (
              lib.attrsets.mapAttrsToList lib.attrsets.nameValuePair cfg.homeRowMods.keybinds
            )
          );
        in
        (lib.lists.unique mods) == mods;
      hyprlandEnabled = config.home.hypr.enable;
    in
    {
      withWlroots = lib.mkDefault hyprlandEnabled;
      withKDE = lib.mkDefault (!cfg.withWlroots);
      config = lib.mkMerge [
        (lib.mkIf cfg.homeRowMods.enable (
          assert uniqueness;
          {
            modmap = [
              {
                name = "home row mods";
                remap = homeRowModsRemaps;
              }
            ];
          }
        ))
      ];
    }
  );
}
