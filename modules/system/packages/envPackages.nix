{ pkgs, inputs, ... }:
{
  imports = [
    ./programming.nix
  ];

  environment.systemPackages = with pkgs; [
    #dependencies
    glibc
    libnotify

    #nixos
    home-manager

    #neovim
    neovim

    alacritty

    libreoffice-qt

    #gaming
    heroic
    protonup

    playerctl

    waybar
    mpd
    #mako
    #rofi-wayland
    blueman
    kdePackages.dolphin
    kdePackages.partitionmanager
    rose-pine-cursor
    networkmanagerapplet
    brightnessctl
    htop-vim
    inputs.cosmos.packages.${pkgs.system}.default
  ];
}
