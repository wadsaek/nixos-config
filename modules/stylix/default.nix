{pkgs,...}:{
  stylix = {
    enable = true;

    base16Scheme = {
      base00 = "242020";
      base01 = "302828";
      base02 = "452d2d";
      base03 = "614343";
      base04 = "cd8888";
      base05 = "d4d4d4";
      base06 = "bd18c4";
      base0F = "e01bd0";
      base09 = "c70d54";
      base08 = "9e1c39";
      base0A = "003fbd";
      base0B = "2652ab";
      base0C = "de7500";
      base0D = "ba6300";
      base0E = "2fc4a4";
      base07 = "1c9978";
    };

    image = ./wallpaper.jpg;
    polarity = "dark";

    cursor = {
      package = pkgs.rose-pine-cursor;
      name = "BreezeX RosePine";
    };

    fonts = {
      monospace = {
        package = pkgs.nerdfonts;
        name = "FiraCode Nerd Font";
      };
    };

    
  };
}
