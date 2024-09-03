{
  description = "System managing flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    #hyprland.url = "github:hyprwm/Hyprland";
    home-manager = {
      url = "github:nix-community/home-manager/";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let 
    system = "x86_64-linux";
    pkgs = import nixpkgs{
      inherit system;

      config = {
        allowUnfree = true;
      };
    };
  in {
    nixosConfigurations = {
      g3-128 = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs system;};
        modules = [
          ./machines/g3-old/configuration.nix
        ];
      };
      g3-1t = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs system;};
 	modules = [
	  ./machines/g3/configuration.nix
	];
      };
    };
    homeConfigurations = {
      wadsaek = home-manager.lib.homeManagerConfiguration {
	inherit pkgs;
	modules = [
	  ./users/wadsaek/home.nix
	];
      };
    };
  };
  
}
