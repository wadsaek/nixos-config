{ inputs, system, ... }:
{
  nixpkgs = import ../../../nixpkgs.nix { inherit inputs system; };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
  programs.nix-ld = {
    enable = true;
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
