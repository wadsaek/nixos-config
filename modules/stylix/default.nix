{pkgs,inputs, ...}:{
  stylix = {
    enable = true;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/da-one-ocean.yaml";
    #{
    #  base00 = "242020";
    #  base01 = "302828";
    #  base02 = "452d2d";
    #  base03 = "614343";
    #  base04 = "cf8888";
    #  base05 = "d47474";
    #  base06 = "ba3a5a";
    #  base07 = "c70d54";
    #  base0B = "88248f";
    #  base0F = "ba3c9b";
    #  base09 = "003fbd";
    #  base0D = "2652ab";
    #  base0A = "de7500";
    #  base0E = "ba6300";
    #  base08 = "2fc4a4";
    #  base0C = "1c9978";
    #};

    image = ./wallpaper.jpg;
    polarity = "dark";

    cursor = {
      size = 32;
      package = inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default;
      name = "rose-pine-hyprcursor";
    };

    fonts = {
      monospace = {
        package = pkgs.nerdfonts;
        name = "FiraCode Nerd Font";
      };
    };
    
  };
}
