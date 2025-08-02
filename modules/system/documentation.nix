{ pkgs, ... }:
{
  documentation.enable = true;
  documentation.dev.enable = true;
  documentation.man.enable = true;
  environment.systemPackages = [
    pkgs.linux-manual
    pkgs.man-pages
    pkgs.man-pages-posix
  ];
}
