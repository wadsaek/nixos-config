{ ... }:
{
  imports = [
    ./../../modules/home/home.nix
    ./../../modules/stylix/homeManager.nix
  ];

  home.hypr.enable = true;
  nixvim.enable = true;
  mangohud.enable = true;
  services.xremap = {
    enable = false; # wow this actually sucks so much wtf
    homeRowMods.enable = true;
  };

  home.username = "wadsaek";
  home.homeDirectory = "/home/wadsaek";
}
