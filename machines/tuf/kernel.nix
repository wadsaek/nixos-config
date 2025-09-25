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
        version = "6.16.2-arch1";
        modDirVersion = version;

        # Fetch the Arch kernel source
        src = fetchzip {
          url = "https://github.com/archlinux/linux/archive/refs/tags/v${version}.tar.gz";
          hash = "sha256-bXRHcYMWKiGj/4QgjVfcs7a92at46it0cf2eAfb6pxA=";
        };

        # Fetch the patches and sort them from [A-Z] then [0-9]
        # This should place 'asus-patch-series.patch' first
        patchDir = fetchgit {
          url = "https://aur.archlinux.org/linux-g14.git";
          rev = "9ae8737769293e1ed970c2cc753463759fecd058";
          hash = "sha256-a07WagrI0LvNWcYJ1WPsnVJJTV3KDo+R19GgqkMdak0=";
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
