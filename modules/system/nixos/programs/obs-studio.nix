{
  pkgs,
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.myModules.programs.obs.enable {
    nixpkgs.overlays = [
      (final: prev: {
        obs-studio = (prev.obs-studio.override ({
            browserSupport = false;
          }
          // lib.optionalAttrs config.myModules.programs.obs.nvidia {
            cudaSupport = true;
            stdenv =
              prev.stdenvAdapters.withCFlags [
                "-O3"
                "-march=native"
                "-fomit-frame-pointer"
                "-flto=auto"
                "-ffat-lto-objects"
                "-fdebug-types-section"
                "-femit-struct-debug-baseonly"
                "-g1"
                "-gno-column-info"
                "-gno-variable-location-views"
              ]
              prev.stdenv;
          })).overrideAttrs (old: {
          buildInputs = builtins.filter (p: p != prev.libvlc) old.buildInputs;
          cmakeFlags =
            old.cmakeFlags
            ++ [
              (lib.cmakeBool "ENABLE_VLC" false)
            ];

          # Rebuild preFixup without libvlc in wrapperLibraries, since the
          # upstream expression bakes it into LD_LIBRARY_PATH regardless
          # of whether the plugin was actually built.
          preFixup = let
            wrapperLibraries = [
              prev.libx11
              prev.libGL
            ];
          in
            ''
              qtWrapperArgs+=(
                  --prefix LD_LIBRARY_PATH : "$out/lib:${lib.makeLibraryPath wrapperLibraries}"
                  ''${gappsWrapperArgs[@]}
              )
            ''
            + lib.optionalString (old.passthru.browserSupport or false) ''
              rm $out/lib/obs-plugins/libcef.so
              rm $out/lib/obs-plugins/libEGL.so
              rm $out/lib/obs-plugins/libGLESv2.so
              rm $out/lib/obs-plugins/libvk_swiftshader.so
              rm $out/lib/obs-plugins/libvulkan.so.1
              rm $out/lib/obs-plugins/chrome-sandbox
            '';
        });
      })
    ];

    programs.obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        obs-pipewire-audio-capture
        obs-vaapi
      ];
    };
  };
}
