{
  old, new, ...
}:
{
  asusctl = old.callPackage old.asusctl.override {
    rustPlatform = old.rustPlatform // {
      buildRustPackage =
        args:
        let
          version = "6.1.0";
        in
        old.rustPlatform.buildRustPackage (
          args
          // {
            src = old.fetchFromGitLab {
              owner = "asus-linux";
              repo = "asusctl";
              rev = "c77e7cf1cedcd2029171a17f90c299924145418e";
              hash = "sha256-P6XAiuy9OtUu48HvnyGJFGM/GdKYDuW7O1X4P9Mr7mw=";
            };
            cargoLock = null;
            useFetchCargoVendor = true;
            cargoHash = "sha256-o+u4k6yGVThBO9Chv4EwVpkDZzZj64RN9iNZyAy0LHs=";

            postPatch = ''
              files="
                asusd-user/src/config.rs
                asusd-user/src/daemon.rs
                asusd/src/aura_anime/config.rs
                rog-aura/src/aura_detection.rs
                rog-control-center/src/lib.rs
                rog-control-center/src/main.rs
                rog-control-center/src/tray.rs
              "
              for file in $files; do
                substituteInPlace $file --replace-fail /usr/share $out/share
              done

              substituteInPlace data/asusd.rules --replace-fail systemctl ${old.lib.getExe' old.systemd "systemctl"}
              substituteInPlace data/asusd.service \
                --replace-fail /usr/bin/asusd $out/bin/asusd \
                --replace-fail /bin/sleep ${old.lib.getExe' old.coreutils "sleep"}
              substituteInPlace data/asusd-user.service \
                --replace-fail /usr/bin/asusd-user $out/bin/asusd-user \
                --replace-fail /usr/bin/sleep ${old.lib.getExe' old.coreutils "sleep"}

              substituteInPlace Makefile \
                --replace-fail /usr/bin/grep ${old.lib.getExe old.gnugrep}

              substituteInPlace /build/asusctl-${version}-vendor/sg-0.4.0/build.rs \
                --replace-fail /usr/include ${old.lib.getDev old.glibc}/include
            '';

            nativeBuildInputs = [
              new.pkg-config
              new.rustPlatform.bindgenHook
            ];

            buildInputs = [
              new.fontconfig
              new.libGL
              new.libinput
              new.libxkbcommon
              new.libgbm
              new.seatd
              new.systemd
              new.wayland
            ];

            # force linking to all the dlopen()ed dependencies
            RUSTFLAGS = map (a: "-C link-arg=${a}") [
              "-Wl,--push-state,--no-as-needed"
              "-lEGL"
              "-lfontconfig"
              "-lwayland-client"
              "-Wl,--pop-state"
            ];

            # upstream has minimal tests, so don't rebuild twice
            doCheck = false;

            postInstall = ''
              make prefix=$out install-data
            '';
          }
        );
    };
  };
}
