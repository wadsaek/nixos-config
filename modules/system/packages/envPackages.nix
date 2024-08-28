{pkgs, ...}:
(with pkgs; [
    #dependencies
    glibc
    libnotify

    #nixos
    home-manager

    #neovim
    neovim
    
    #fun
    lolcat
    blahaj
    cowsay
    pipes
    ani-cli

    #cli
    lf
    spotify-player 
    alacritty
    bat
    ripgrep
    zellij
    mprocs
    asciiquarium
    cmatrix
    fzf
    
    obsidian
    spotify
    davinci-resolve
    gimp
    libreoffice-qt
    grim
    opera
    
    #gaming
    heroic
    mangohud
    protonup

    tg   
    discord
    betterdiscordctl
    zapzap
    whatsapp-for-linux
    telegram-desktop
    playerctl

    (waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
    }))
    mpd
    mako
    wpaperd
    rofi-wayland
    blueman
    kdePackages.dolphin
    kdePackages.partitionmanager
    rose-pine-cursor
    networkmanagerapplet
    brightnessctl
])
