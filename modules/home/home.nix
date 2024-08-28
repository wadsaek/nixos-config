{ config, pkgs, ... }:

{
  imports = [
    ./hypr.nix
    ./nu.nix
    ./yazi.nix
    ./kitty.nix
    ./waybar.nix
    ./starship.nix
  ];

  home.username = "wadsaek";
  home.homeDirectory = "/home/wadsaek";

  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.packages = [
  ];

  home.file = {
  };

  home.sessionVariables = {
  };

  programs.home-manager.enable = true;

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.rose-pine-cursor;
    name = "BreezeX-RosePine";
    size = 16;
  };
  
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
}
