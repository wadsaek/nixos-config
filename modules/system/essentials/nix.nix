{
  inputs,
  system,
  pkgs,
  ...
}:
{
  nixpkgs = import ../../../nixpkgs { inherit inputs system; };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
    "pipe-operators"
  ];
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
  programs.nix-ld = {
    enable = true;
    libraries = [
      pkgs.gtk3
      pkgs.libnotify
    ];
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
