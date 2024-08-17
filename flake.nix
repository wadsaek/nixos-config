{
  description = "System managing flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    #hyprland.url = "github:hyprwm/Hyprland";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, ... }@inputs:
  let 
    system = "x84_64-linux";
    pkgs = import nixpkgs{
      inherit system;

      config = {
        allowUnfree = true;
      };
    };
  in{

    nixosConfigurations = {
      myConfig = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs system;};
        modules = [
          ./nixos/configuration.nix
        ];
      };
    };
  };
  
}
