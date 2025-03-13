{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  imports = [
    ./commandLine
    ./entertainment
    ./qoa
    ./services
    ./options.nix

    ./hypr.nix
    ./waybar
    ./eww
    ./cosmosConfig.nix

    ./yazi.nix
    ./kitty.nix

    ./mako.nix
    ./rofi.nix
  ];

  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.packages =
    with pkgs;
    [
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
      (callPackage ./donut.nix { })

      #cli
      ripgrep
      mprocs
      asciiquarium
      cmatrix

      obsidian
      spotify
      musescore

      grim
      oculante
      mpv

      opera
      ddgr

      tg
      discord
      betterdiscordctl
      zapzap
      whatsapp-for-linux
      telegram-desktop

      inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
    ]
    ++ lib.optionals config.home.mediaEditing.enable [
      davinci-resolve
      inkscape
      gimp
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
    userEmail = "wadsaek@gmail.com";
    userName = "wadsaek";
    package = pkgs.gitFull;
    enable = true;
    signing.format = "ssh";
    signing.key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMmFXfWeAY+Nh5z6HKW8BwMhDS0oucpFSN824RiX/7o2 wadsaek@gmail.com";
    extraConfig = {
      gpg = {
        ssh.allowedSignersFile = "${config.home.homeDirectory}/.config/git/allowed_signers";
      };
    };
    ignores = [
      ".envrc"
      ".env"
      "_start.sh" # custom start-scripts
      ".direnv"
      "tmux-session.nu" # tmux scripts
    ];
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
  services.xremap.enable = lib.mkDefault false;
}
