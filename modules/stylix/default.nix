{ pkgs, inputs, ... }:
{
  stylix = {
    enable = true;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/da-one-ocean.yaml";

    image = ./wallpaper.jpg;
    polarity = "dark";

    cursor = {
      size = 32;
      package = pkgs.rose-pine-cursor;
      name = "BreezeX-RosePine-Linux";
    };

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.fira-code;
        name = "FiraCode Nerd Font";
      };
      sansSerif = {
        package = pkgs.aileron;
        name = "Aileron SemiBold";
      };
      serif = {
        package = pkgs.inriafonts;
        name = "Inria Serif";
      };
    };

  };
}
