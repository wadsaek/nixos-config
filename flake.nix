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
    flake-utils.url = "github:numtide/flake-utils";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-unstable-small.url = "github:nixos/nixpkgs/nixos-unstable-small";
    nixos-unstable-pinned.url = "github:nixos/nixpkgs/d89fc19e405cb2d55ce7cc114356846a0ee5e956";

    home-manager = {
      url = "github:nix-community/home-manager/";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:wadsaek/nixvim/";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    cosmos = {
      url = "git+https://codeberg.org/ext0l/cosmos.git";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix";
    rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";
    xremap-flake.url = "github:xremap/nix-flake";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      flake-utils,
      ...
    }@inputs:
    flake-utils.lib.eachDefaultSystemPassThrough (
      system:
      let
        pkgs = import nixpkgs (
          import ./nixpkgs.nix {
            inherit inputs system;
          }
        );

        mkNixosConfiguration =
          modules:
          nixpkgs.lib.nixosSystem {
            specialArgs = {
              inherit inputs system;
            };
            modules = modules ++ [
              inputs.stylix.nixosModules.stylix
              inputs.cosmos.nixosModules.default
            ];
          };

        nixvim = inputs.nixvim.packages.${system}.full.extend {
          nixpkgs.pkgs = pkgs;
        };
        mkHomeConfiguration =
          modules:
          home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            extraSpecialArgs = {
              inherit inputs nixvim;
            };
            modules = modules ++ [
              inputs.spicetify-nix.homeManagerModules.spicetify
              inputs.stylix.homeModules.stylix
            ];
          };
      in
      {
        nixosConfigurations = {
          Esther-g3 = mkNixosConfiguration [ ./machines/g3-old/configuration.nix ];
          Esther-tuf = mkNixosConfiguration [ ./machines/tuf/configuration.nix ];
        };
        homeConfigurations = {
          wadsaek = mkHomeConfiguration [ ./users/wadsaek/home.nix ];
          wadsaek-little = mkHomeConfiguration [ ./users/wadsaek-little/home.nix ];
        };

        formatter.${system} = pkgs.nixfmt-rfc-style;
      }
    );
}
