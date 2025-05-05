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

            patch_dir = fetchgit {
              url = "https://aur.archlinux.org/linux-g14.git";
              rev = "ad71f536b2be541b43417fcd87b2ff6f57fcfa89";
              hash = "sha256-kPaOmzS2L9ZXRhxWKgXlNF1dZkcrr/3IGxa+Dx3hHu0=";
            };

            src = fetchzip {
              url = "https://github.com/archlinux/linux/archive/refs/tags/v${version}.tar.gz";
              hash = "sha256-pWs/vkMvxvzsqC+ezXGER1kqQzkJAxCIDcL6dyU4jcM=";
            };
            kernelPatches =
              [
                {
                  name = "asus-patch-series.patch";
                  patch = "${patch_dir}/asus-patch-series.patch";
                }
                {
                  name = "0001-acpi-proc-idle-skip-dummy-wait.patch";
                  patch = "${patch_dir}/0001-acpi-proc-idle-skip-dummy-wait.patch";
                }
                {
                  name = "0004-ACPI-resource-Skip-IRQ-override-on-ASUS-TUF-Gaming-A.patch";
                  patch = "${patch_dir}/0004-ACPI-resource-Skip-IRQ-override-on-ASUS-TUF-Gaming-A.patch";
                }
                {
                  name = "0005-ACPI-resource-Skip-IRQ-override-on-ASUS-TUF-Gaming-A.patch";
                  patch = "${patch_dir}/0005-ACPI-resource-Skip-IRQ-override-on-ASUS-TUF-Gaming-A.patch";
                }
                {
                  name = "0007-workaround_hardware_decoding_amdgpu.patch";
                  patch = "${patch_dir}/0007-workaround_hardware_decoding_amdgpu.patch";
                }
                {
                  name = "0008-amd-tablet-sfh.patch";
                  patch = "${patch_dir}/0008-amd-tablet-sfh.patch";
                }
                {
                  name = "0009-asus-nb-wmi-Add-tablet_mode_sw-lid-flip.patch";
                  patch = "${patch_dir}/0009-asus-nb-wmi-Add-tablet_mode_sw-lid-flip.patch";
                }
                {
                  name = "0010-asus-nb-wmi-fix-tablet_mode_sw_int.patch";
                  patch = "${patch_dir}/0010-asus-nb-wmi-fix-tablet_mode_sw_int.patch";
                }
                {
                  name = "0011-amdgpu-adjust_plane_init_off_by_one.patch";
                  patch = "${patch_dir}/0011-amdgpu-adjust_plane_init_off_by_one.patch";
                }
              ];

            defconfig = "${patch_dir}/config";
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
