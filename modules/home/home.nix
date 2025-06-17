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
      drawio

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
      (callPackage (
        { appimageTools, fetchurl }:
        let
          pname = "musescore-appimage";
          version = "4.5.1";
          src = fetchurl {
            url = "https://cdn.jsdelivr.net/musescore/v${version}/MuseScore-Studio-${version}.250800846-x86_64.AppImage";
            sha256 = "a986c2b15ecf2bbe397117a3c4addf56a9b08c88f6e9cecfceacfbc0ec404799";
          };
          appimageContents = appimageTools.extractType2 { inherit pname version src; };
        in
        appimageTools.wrapType2 {
          inherit pname version src;

          extraInstallCommands = ''
            install -Dm444 ${appimageContents}/share/applications/org.musescore.MuseScore4portable.desktop -t $out/share/applications
            substituteInPlace $out/share/applications/org.musescore.MuseScore4portable.desktop \
              --replace-fail 'Exec=mscore4portable %U' 'Exec=${pname}'
            cp -r ${appimageContents}/share/icons $out/share
          '';
        }
      ) { })

      grim
      oculante
      mpv

      firefox
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
      blender
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

  xdg.enable = true;

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
    signing.key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID3zJ6C52f/ykyhNC65t590I/AwNbHIIXCWlVoX2ORp4 wadsaek@gmail.com";
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
