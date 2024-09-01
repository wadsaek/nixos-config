{pkgs, lib, config, ... }:{
  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      devices = [ "nodev" ];
      efiSupport = true;
      #useOSProber = true;
      default ="saved";
      theme = "${
        (pkgs.fetchFromGitHub{
          owner = "OliveThePuffin";
          repo = "yorha-grub-theme";
          rev = "4d9cd37baf56c4f5510cc4ff61be278f11077c81";
          sha256 = "sha256-XVzYDwJM7Q9DvdF4ZOqayjiYpasUeMhAWWcXtnhJ0WQ=";
        })
      }/yorha-${config.resolution.horizontal}x${config.resolution.vertical}";
    };
  };
}
