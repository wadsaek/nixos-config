{
  pkgs,
  config,
  lib,
  ...
}:
{
  options.fonts.full = lib.mkEnableOption "full fonts";
  config.fonts.packages =
    if config.fonts.full then
      with pkgs;
      [
        siji
        inriafonts
        roboto
        inter
        minecraftia
        cherry
        dotcolon-fonts
        junicode
        icomoon-feather
        eunomia
        culmus
        noto-fonts
        noto-fonts-extra
        noto-fonts-emoji
        noto-fonts-color-emoji
        noto-fonts-emoji-blob-bin
        junction-font
        aileron
        comic-relief
        times-newer-roman
        alegreya
        manrope
        tenderness
        fira-math
        linja-sike
        weather-icons
        hyperscrypt-font
      ]
      ++ (lib.lists.filter lib.isDerivation (pkgs.lib.attrValues pkgs.nerd-fonts))
    else
      [
        pkgs.inriafonts
        pkgs.nerd-fonts.fira-code
        pkgs.aileron
      ];
}
