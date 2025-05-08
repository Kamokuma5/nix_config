{ config, pkgs, lib, inputs, outputs, pkgs_unstable, ... }:

let
  isKDEInstalled = config.services.desktopManager.plasma6.enable;
in
{
  # ASUS G14 Patched Kernel based off of Arch Linux Kernel
  boot.kernelPackages =
    let
      linux_g14_pkg =
        { fetchurl, fetchzip, fetchgit, buildLinux, ... }@args:

        buildLinux (
          args
          // rec {
            version = "6.14.5-arch1";
            modDirVersion = version;
            kernalPatchRev = "5f7c2f39a153be2ca29057e0a2d6c5651edecddb";

            # Fetch the Arch kernel source
            src = fetchzip {
              url = "https://github.com/archlinux/linux/archive/refs/tags/v${version}.tar.gz";
              hash = "sha256-pWs/vkMvxvzsqC+ezXGER1kqQzkJAxCIDcL6dyU4jcM=";
            };

            # Fetch the patches and sort them from [A-Z] then [0-9]
            # This should place 'asus-patch-series.patch' first
            patchDir = fetchgit {
              url = "https://aur.archlinux.org/linux-g14.git";
              rev = "ad71f536b2be541b43417fcd87b2ff6f57fcfa89";
              hash = "sha256-kPaOmzS2L9ZXRhxWKgXlNF1dZkcrr/3IGxa+Dx3hHu0=";
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
            map (file: { name = file; patch = "${patchDir}/${file}"; }) sortedPatches;

            defconfig = "${patchDir}/config";
          }
          // (args.argsOverride or { })
        );
      linux_g14 = pkgs.callPackage linux_g14_pkg { };
    in
    pkgs.recurseIntoAttrs (pkgs.linuxPackagesFor linux_g14);

  services = {
    # supergfxd controls GPU switching
    supergfxd.enable = true;

    # ASUS specific software. This also installs asusctl.
    asusd = {
      enable = true;
      enableUserService = true;
      package = pkgs_unstable.asusctl;
    };

    # Dependency of asusd
    power-profiles-daemon.enable = true;
  };

  # Install plasmoid if KDE is also installed.
  environment.systemPackages = with pkgs;
    builtins.filter (pkg: pkg != null) ([
      (if isKDEInstalled then supergfxctl-plasmoid else null)
    ]);
}
