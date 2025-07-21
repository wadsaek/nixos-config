{ pkgs, ... }:
let
  linux_g14_pkg =
    {
      fetchzip,
      fetchgit,
      buildLinux,
      ...
    }@args:

    buildLinux (
      args
      // rec {
        version = "6.15.6-arch1";
        modDirVersion = version;
        kernalPatchRev = "5f7c2f39a153be2ca29057e0a2d6c5651edecddb";

        # Fetch the Arch kernel source
        src = fetchzip {
          url = "https://github.com/archlinux/linux/archive/refs/tags/v${version}.tar.gz";
          hash = "sha256-DY+eNMwD+19ZweBECKUdkZxCp4ttH04LFfrjrVXpYRU=";
        };

        # Fetch the patches and sort them from [A-Z] then [0-9]
        # This should place 'asus-patch-series.patch' first
        patchDir = fetchgit {
          url = "https://aur.archlinux.org/linux-g14.git";
          rev = "8e1dfce7277a5a75e375155d6a6bc5f35e233a56";
          hash = "sha256-VuvZSk+Rsy/2/t281332BVSU5IZEREZhNgni2Gforx0=";
        };

        kernelPatches =
          let
            patchFiles = builtins.attrNames (builtins.readDir patchDir);

            # Filter only `.patch` files
            isPatchFile = name: builtins.match ".*\\.patch" name != null;
            patchFilesFiltered = builtins.filter isPatchFile patchFiles;

            # Separate non-numeric and numeric patches
            isNumeric = name: builtins.match "[0-9]+.*\\.patch" name != null;
            numericPatches = builtins.sort builtins.lessThan (builtins.filter isNumeric patchFilesFiltered);
            nonNumericPatches = builtins.filter (name: !isNumeric name) patchFilesFiltered;

            # Combine lists: non-numeric first, then numeric
            sortedPatches = nonNumericPatches ++ numericPatches;
          in
          map (file: {
            name = file;
            patch = "${patchDir}/${file}";
          }) sortedPatches;

        defconfig = "${patchDir}/config";
      }
      // (args.argsOverride or { })
    );
  linux_g14 = pkgs.callPackage linux_g14_pkg { };
in
pkgs.recurseIntoAttrs (pkgs.linuxPackagesFor linux_g14)
