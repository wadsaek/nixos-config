{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.lfs.enable = lib.mkEnableOption "lfs";
  config = lib.mkIf config.lfs.enable {
    environment.sessionVariables = {
      LFS = "/mnt/lfs";
    };
    users.users.lfs = {
      isNormalUser = true;
      extraGroups = [
        "networkmanager"
        "wheel"
      ];

      shell = pkgs.bash;
      packages = with pkgs; [
        bash
        coreutils
        binutils
        bison
        diffutils
        findutils
        gawk
        gcc
        gzip
        m4
        gnumake
        cmake
        patch
        perl
        python313
        texinfo
        xz
      ];
    };
    users.groups.lfs.members = [ "lfs" ];
  };
}
