{...}:{
  imports = [
    ./../../modules/home/home.nix
    ./../../modules/stylix/homeManager.nix
  ];
  
  home.hypr.enable = true;
  nixvim.enable = true;
  mangohud.enable = true;

  home.username = "wadsaek";
  home.homeDirectory = "/home/wadsaek";
}
