{ ... }:
{
  imports = [
    ./bootloader.nix
    ./sound/sound.nix
    ./network/network.nix
    ./kernel.nix
    ./fwupd.nix
  ];
}
