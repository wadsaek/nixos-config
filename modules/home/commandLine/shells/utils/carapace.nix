{lib,config,...}:{
  programs.carapace.enable = lib.mkDefault config.home.nu.enable;
}
