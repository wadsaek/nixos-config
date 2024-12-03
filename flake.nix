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
    nixos-unstable-small.url = "github:nixos/nixpkgs/nixos-unstable-small";
    nixos-unstable-pinned.url = "github:nixos/nixpkgs/ac35b104800bff9028425fec3b6e8a41de2bbfff";
    home-manager = {
      url = "github:nix-community/home-manager/";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:wadsaek/nixvim/";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    cosmos = {
      url = "git+http://codeberg.org/ext0l/cosmos.git";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";
    rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";
    xremap-flake.url = "github:xremap/nix-flake";
  };
  outputs =
    { nixpkgs, home-manager, ... }@inputs:
    let
      nixpkgs_options = {
        inherit system;

        config = {
          allowUnfree = true;
          trusted-users = [
            "root"
            "wadsaek"
          ];
        };
      };
      system = "x86_64-linux";
      pkgs = import nixpkgs (
        nixpkgs_options
        // {
          overlays =
            let
              nixos-unstable-small = import inputs.nixos-unstable-small nixpkgs_options;
              nixos-unstable-pinned = import inputs.nixos-unstable-pinned nixpkgs_options;
            in
            [
              (final: prev: {
                opera = prev.opera.override {
                  proprietaryCodecs = true;
                };
                blahaj = prev.blahaj.overrideAttrs {
                  owner = "GeopJr";
                  repo = "BLAHAJ";
                  rev = "6e5ba24f471b31080ca35cabcf7bb16a0d56e846";
                  hash = "sha256-8AM2yVqLx3JmDyyu+46hy7d9pD9hC/0aeqqmtpYhbB0=";
                };

                inherit (nixos-unstable-small) omnisharp-roslyn;
                inherit (nixos-unstable-pinned) libreoffice-qt davinci-resolve;
              })
            ];
        }
      );
    in
    {
      nixosConfigurations = {
        Esther-g3 = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs system;
          };
          modules = [
            ./machines/g3/configuration.nix
            inputs.stylix.nixosModules.stylix
            inputs.cosmos.nixosModules.default
          ];
        };
      };
      homeConfigurations = {
        wadsaek = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit (inputs) nixvim;
            inherit inputs;
          };
          modules = [
            inputs.stylix.homeManagerModules.stylix
            ./users/wadsaek/home.nix
          ];
        };
      };
    };

}
