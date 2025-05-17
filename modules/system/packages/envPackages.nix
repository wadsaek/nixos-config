{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
{
  imports = [
    ./programming.nix
  ];

  options.packages = {
    full = lib.mkEnableOption "all packages";
    graphical = lib.mkOption {
      type = lib.types.bool;
      description = "whether to include graphical packages";
      default = config.packages.full;
    };
  };
  config.environment.systemPackages =
    [
      #dependencies
      pkgs.glibc
      pkgs.libnotify

      #nixos
      pkgs.home-manager

      #neovim
      pkgs.neovim

      pkgs.file
      pkgs.speedtest-rs
    ]
    ++ lib.optionals config.steam.enable [
      pkgs.heroic
      pkgs.protonup
    ]
    ++ lib.optionals config.packages.full [
      pkgs.playerctl
      pkgs.mpd
      pkgs.blueman
      pkgs.brightnessctl
      pkgs.htop-vim
      pkgs.btop
    ]
    ++ lib.optionals config.packages.graphical [
      pkgs.waybar
      pkgs.kdePackages.dolphin
      pkgs.kdePackages.partitionmanager
      pkgs.rose-pine-cursor
      pkgs.networkmanagerapplet
    ]
    ++ lib.optionals (with config.packages; (graphical && full)) [
      pkgs.libreoffice-qt
      pkgs.alacritty
      inputs.cosmos.packages.${pkgs.system}.default
    ];
}
