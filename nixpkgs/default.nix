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
        blahaj = prev.blahaj.overrideAttrs {
          src = final.fetchFromGitHub {
            owner = "GeopJr";
            repo = "BLAHAJ";
            rev = "6e5ba24f471b31080ca35cabcf7bb16a0d56e846";
            hash = "sha256-8AM2yVqLx3JmDyyu+46hy7d9pD9hC/0aeqqmtpYhbB0=";
          };
        };
        inherit (unstable-pinned) libreoffice-qt davinci-resolve;
      })
      (final: prev: {
        niri = prev.niri.overrideAttrs {
          src = final.fetchFromGitHub {
            owner = "wadsaek";
            repo = "niri";
            rev = "78de30afddfbebcba597719231b3cfaf2028e76b";
            hash = "sha256-k1OAK1akgQHud0YvKrpuzlyM6KcEMaNEU4Yw/G/8Cyw=";
          };
        };
      })
      (import ./utils.nix)
    ];
}
