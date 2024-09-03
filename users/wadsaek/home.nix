{...}:{
  imports = [
    ./../../modules/home/home.nix
  ];
  
  home.hypr.enable = true;

  home.username = "wadsaek";
  home.homeDirectory = "/home/wadsaek";
}
