{
  inputs,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./../../modules/home/home.nix
    ./../../modules/stylix/homeManager.nix
  ];

  home.packages =
    let
      nixvim = inputs.nixvim.packages.${pkgs.stdenv.hostPlatform.system}.minimal.extend {
        nixpkgs = lib.mkForce { inherit pkgs; };
        nix.enable = true;
      };
    in
    [ nixvim ];

  home.hypr.enable = true;
  home.kitty.enable = true;
  home.wl-clipboard.enable = true;
  home.fzf.enable = true;
  home.tmux.enable = true;
  home.zsh.enable = true;

  home.username = "wadsaek";
  home.homeDirectory = "/home/wadsaek";
}
