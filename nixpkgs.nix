{
  inputs,
  system,
}:
let
  inherit (inputs)
    nixos-unstable-pinned
    nixos-unstable-small
    ;
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
in
nixpkgs_options
// {
  overlays =
    let
      unstable-small = import nixos-unstable-small nixpkgs_options;
      unstable-pinned = import nixos-unstable-pinned nixpkgs_options;
    in
    [
      (final: prev: {
        electron_31 = final.electron;
        harper = final.rustPlatform.buildRustPackage {
          pname = "harper";
          version = "master";

          src = final.fetchFromGitHub {
            owner = "Automattic";
            repo = "harper";
            rev = "9a95810310086788d0da39d97fc0aa4453ffaf98";
            hash = "sha256-ceFh64e3Odb5Wj7JwGgRYwcOgZnCtnPZaTuQ6XmccUo=";
          };

          cargoHash = "sha256-e9hWRxiO34JxpG2KppZxarBC3YiqHZbdfy5jYq0Wqwk=";
        };
        opera = prev.opera.override {
          proprietaryCodecs = true;
        };
        blahaj = prev.blahaj.overrideAttrs {
          owner = "GeopJr";
          repo = "BLAHAJ";
          rev = "6e5ba24f471b31080ca35cabcf7bb16a0d56e846";
          hash = "sha256-8AM2yVqLx3JmDyyu+46hy7d9pD9hC/0aeqqmtpYhbB0=";
        };
        inherit (unstable-small) ghostty;
        inherit (unstable-pinned) libreoffice-qt davinci-resolve;
      })
    ];
}
