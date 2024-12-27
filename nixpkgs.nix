{
  nixpkgs,
  nixos-unstable-small,
  nixos-unstable-pinned,
  system,
}:
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
in
import nixpkgs (
  nixpkgs_options
  // {
    overlays =
      let
        unstable-small = import nixos-unstable-small nixpkgs_options;
        unstable-pinned = import nixos-unstable-pinned nixpkgs_options;
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

          inherit (unstable-small) omnisharp-roslyn;
          inherit (unstable-pinned) libreoffice-qt davinci-resolve;
        })
      ];
  }
)
