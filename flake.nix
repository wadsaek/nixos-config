{
  description = "System managing flake";
  
  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    #hyprland.url = "github:hyprwm/Hyprland";
    home-manager = {
      url = "github:nix-community/home-manager/";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:wadsaek/nixvim/";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";
    rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";
  };
  outputs = {nixpkgs, home-manager, ... }@inputs:
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
      Esther-g3 = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs system;};
 	modules = [
	  ./machines/g3/configuration.nix
	  inputs.stylix.nixosModules.stylix
	];
      };
    };
    homeConfigurations = {
      wadsaek = home-manager.lib.homeManagerConfiguration {
	inherit pkgs;
	extraSpecialArgs = {inherit (inputs) nixvim;inherit inputs;};
	modules = [
	  inputs.stylix.homeManagerModules.stylix
	  ./users/wadsaek/home.nix
	];
      };
    };
  };
  
}
