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

    ./hypr
    ./waybar
    ./eww
    # ./cosmosConfig.nix

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
      drawio
      jq

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
      ripgrep-all
      ripgrep
      mprocs
      asciiquarium
      cmatrix
      wiki-tui

      obsidian
      musescore

      grim
      oculante
      mpv

      firefox
      ddgr

      tg
      discord
      betterdiscordctl
      zapzap
      wasistlos
      telegram-desktop
      element-desktop
      signal-desktop

      qbittorrent

      inputs.rose-pine-hyprcursor.packages.${pkgs.stdenv.hostPlatform.system}.default
    ]
    ++ lib.optionals config.home.mediaEditing.enable [
      krita
      xournalpp
      blender
      davinci-resolve
      inkscape
      gimp
    ]
    ++ import ./scripts { inherit pkgs; };

  home.file = {
  };

  programs.home-manager.enable = true;

  xdg.enable = true;

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
    settings = {
      user.email = "wadsaek@gmail.com";
      user.name = "wadsaek";
      gpg = {
        ssh.allowedSignersFile = "${config.home.homeDirectory}/.config/git/allowed_signers";
      };
    };
    signing = {
      format = "ssh";
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID3zJ6C52f/ykyhNC65t590I/AwNbHIIXCWlVoX2ORp4 wadsaek@gmail.com";
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
