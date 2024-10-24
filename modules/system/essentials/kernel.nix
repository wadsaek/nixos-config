{ pkgs, lib, ... }:
{
  boot.kernelPackages = lib.mkDefault pkgs.linuxKernel.packages.linux_zen;
}
