{ pkgs, inputs, ... }:
{
  imports = [
    ./programming.nix
  ];

  environment.systemPackages = [
    #dependencies
    pkgs.glibc
    pkgs.libnotify

    #nixos
    pkgs.home-manager

    #neovim
    pkgs.neovim

    pkgs.alacritty

    pkgs.libreoffice-qt

    #gaming
    pkgs.heroic
    pkgs.protonup

    pkgs.playerctl

    pkgs.waybar
    pkgs.mpd
    pkgs.blueman
    pkgs.kdePackages.dolphin
    pkgs.kdePackages.partitionmanager
    pkgs.rose-pine-cursor
    pkgs.networkmanagerapplet
    pkgs.brightnessctl
    pkgs.htop-vim
    pkgs.btop
    inputs.cosmos.packages.${pkgs.system}.default
  ];
}
