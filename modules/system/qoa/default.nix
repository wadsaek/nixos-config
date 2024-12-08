{ lib, ... }:
{
  imports = [
    ./nh.nix
    ./kmscon.nix
  ];
  nh.enable = lib.mkDefault true;
}
