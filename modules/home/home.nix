{ config, pkgs, lib, inputs,... }: {
  imports = [
    ./commandLine 
    ./entertainment

    ./hypr.nix
    ./yazi.nix
    ./kitty.nix
    ./waybar.nix

    ./mako.nix
    ./rofi.nix
  ];


  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    nix-output-monitor
    porsmo

    walker

    #fun
    lolcat
    blahaj
    cowsay
    pipes
    ani-cli
    cbonsai

    #cli
    ripgrep
    mprocs
    asciiquarium
    cmatrix

    obsidian
    spotify
    musescore

    davinci-resolve
    gimp

    grim
    opera
    ddgr

    tg   
    discord
    betterdiscordctl
    zapzap
    whatsapp-for-linux
    telegram-desktop

    inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
  ];

  home.file = {
  };

  home.sessionVariables = {
    FLAKE = "git+ssh://git@github.com:wadsaek/nixos-config.git";
  };

  programs.home-manager.enable = true;

  #home.pointerCursor = {
  #  gtk.enable = true;
  #  x11.enable = true;
  #  package = pkgs.rose-pine-cursor;
  #  name = "BreezeX-RosePine";
  #  size = 16;
  #};
  
  programs.git = {
    package = pkgs.gitFull;
    enable = true;
  };


  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-vaapi
      obs-pipewire-audio-capture
    ];
  };
  programs.fastfetch = {
    enable = true;
   # settings = {
   #   logo = {
   #     source = "nixos";
   #     padding = {
   #       right = 1;
   #     };
   #   };
   #   display ={
   #     size = {
   #         binaryPrefix = "si";
   #       };
   #     color = "blue";
   #   };
   #   modules = [
   #     {
   #       type = "datetime";
   #       key = "Date";
   #       format = "{1}-{3}-{11}";
   #     }
   #     {
   #       type = "datetime";
   #       key = "Time";
   #       format = "{14}:{17}:{20}";
   #     }
   #     "datetime"
   #     "title"
   #     "sepatator"
   #     "player"
   #     "media"
   #   ];
   # };
  };

  home.starship.enable = lib.mkDefault true;
  home.nu.enable = lib.mkDefault true;
  home.zsh.enable = lib.mkDefault true;
  home.kitty.enable = lib.mkDefault true;
  home.yazi.enable = lib.mkDefault true;
  home.wl-clipboard.enable = lib.mkDefault true;
  home.spotify-player.enable = lib.mkDefault true;
  home.mako.enable = lib.mkDefault true;
  home.alacritty.enable = lib.mkDefault true;
  home.bat.enable = lib.mkDefault true;
  home.fzf.enable = lib.mkDefault true;
  home.zellij.enable = lib.mkDefault true;
  home.rofi.enable = lib.mkDefault true;
  home.tmux.enable = lib.mkDefault true;
  home.direnv.enable = lib.mkDefault true;
}
