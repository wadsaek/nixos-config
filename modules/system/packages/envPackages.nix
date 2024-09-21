{pkgs, ...}: {
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
    mangohud
    protonup

    playerctl

    (waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
    }))
    mpd
    #mako
    #rofi-wayland
    blueman
    kdePackages.dolphin
    kdePackages.partitionmanager
    rose-pine-cursor
    networkmanagerapplet
    brightnessctl
  ];
}
