{ inputs, pkgs, ... }:
let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in
{
  programs.spicetify = {
    theme = spicePkgs.themes.comfy;
    colorScheme = "rose-pine";
  };
}
