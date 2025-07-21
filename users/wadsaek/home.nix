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

  home.starship.enable = true;
  home.nu.enable = true;
  home.zsh.enable = true;
  home.zsh.pay-respects = true;
  home.kitty.enable = true;
  home.yazi.enable = true;
  home.wl-clipboard.enable = true;
  home.spotify-player.enable = true;
  programs.spicetify.enable = true;
  home.mako.enable = true;
  home.alacritty.enable = true;
  home.bat.enable = true;
  home.fzf.enable = true;
  home.zellij.enable = true;
  home.rofi.enable = true;
  home.tmux.enable = true;
  home.direnv.enable = true;
  home.mediaEditing.enable = true;
  services.dropbox.enable = true;
  programs.zoxide.enable = true;
}
