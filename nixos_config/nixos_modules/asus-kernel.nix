{
  config,
  pkgs,
  lib,
  ...
}:

{
  # ASUS G14 Patched Kernel based off of Arch Linux Kernel
  boot.kernelPackages =
    let
      linux_g14_pkg =
        { fetchurl, fetchzip, fetchgit, buildLinux, ... }@args:

        buildLinux (
          args
          // rec {
            version = "6.13.1-arch2";
            modDirVersion = version;

            patch_dir = fetchgit {
              url = "https://aur.archlinux.org/linux-g14.git";
              rev = "485b2b1f5abc703faed64f4fdaa741fe00e5cf19";
              hash = "sha256-HnT4vRi1l2W9UpqS7uC1mxJyyah00y60RHtwHPat42k=";
            };

            src = fetchzip {
              url = "https://github.com/archlinux/linux/archive/refs/tags/v${version}.tar.gz";
              hash = "sha256-oth96B9DX7uCERT4IdsB9JxpSXcOd4uRCOjZlzDa5u0=";
            };
            kernelPatches =
              with {
                patch_series = fetchurl {
                  url = "https://gitlab.com/asus-linux/fedora-kernel/-/raw/rog-6.13/asus-patch-series.patch";
                  hash = "sha256-ECOUhk1TF8VHuOp+LZQTW35VKw6m66SdS9m8FtGgNkA=";
                };
              };

              [
                {
                  name = "0000-asus-patch-series.patch";
                  patch = "${patch_series}";
                }
                {
                  name = "0001-acpi-proc-idle-skip-dummy-wait.patch";
                  patch = "${patch_dir}/0001-acpi-proc-idle-skip-dummy-wait.patch";
                }
                # {
                #   name = "0002-mt76_-mt7921_-Disable-powersave-features-by-default.patch";
                #   patch = "${patch_dir}/0002-mt76_-mt7921_-Disable-powersave-features-by-default.patch";
                # }
                {
                  name = "0004-ACPI-resource-Skip-IRQ-override-on-ASUS-TUF-Gaming-A.patch";
                  patch = "${patch_dir}/0004-ACPI-resource-Skip-IRQ-override-on-ASUS-TUF-Gaming-A.patch";
                }
                {
                  name = "0005-ACPI-resource-Skip-IRQ-override-on-ASUS-TUF-Gaming-A.patch";
                  patch = "${patch_dir}/0005-ACPI-resource-Skip-IRQ-override-on-ASUS-TUF-Gaming-A.patch";
                }
                # {
                #   name = "0006-mediatek-pci-reset.patch";
                #   patch = "${patch_dir}/0006-mediatek-pci-reset.patch";
                # }
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

  # ASUS Specific Software
  services = {
    supergfxd.enable = true;
    asusd = {
      enable = true;
      enableUserService = true;
    };
  };
}
