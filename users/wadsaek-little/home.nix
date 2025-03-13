{ ... }:
{
  imports = [
    ./../../modules/home/home.nix
    ./../../modules/stylix/homeManager.nix
  ];

  home.hypr.enable = true;
  home.kitty.enable = true;
  home.wl-clipboard.enable = true;
  home.fzf.enable = true;
  home.tmux.enable = true;

  home.username = "wadsaek";
  home.homeDirectory = "/home/wadsaek";
}
