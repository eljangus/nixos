{
  config,
  lib,
  self,
  ...
}: {
  options.myModules.system.overlays.zed-corners.enable =
    lib.mkEnableOption "zed-corners overlay" // { default = true;};

  config = lib.mkIf config.myModules.system.overlays.zed-corners.enable {
    # Patching zed-editor changes its output hash, so it no longer matches
    # cache.nixos.org and has to build locally every time nixpkgs bumps the
    # version. sccache caches per-crate compile output across those builds,
    # but the Nix build sandbox can't see ~/.cache or $PATH, so it needs an
    # explicit exception for a fixed cache directory.
    nix.settings.extra-sandbox-paths = ["/var/cache/sccache"];
    systemd.tmpfiles.rules = ["d /var/cache/sccache 0775 root nixbld -"];

    nixpkgs.overlays = [
      (final: prev: {
        zed-corners = prev.zed-editor.overrideAttrs (old: {
          patches = (old.patches or []) ++ [(self + "/patches/zed-corners.patch")];
          RUSTC_WRAPPER = lib.getExe prev.sccache;
          SCCACHE_DIR = "/var/cache/sccache";
          nativeBuildInputs =
            (old.nativeBuildInputs or [])
            ++ [
              # Pin cargo-about to 0.8.2. Newer versions don't work with the current license identifiers
              # See https://github.com/zed-industries/zed/pull/44012
              (prev.cargo-about.overrideAttrs (
                new: old: rec {
                  version = "0.8.2";
                  cargoBuildFeatures = [];
                  cargoCheckFeatures = [];

                  src = prev.fetchFromGitHub {
                    owner = "EmbarkStudios";
                    repo = "cargo-about";
                    tag = version;
                    sha256 = "sha256-cNKZpDlfqEXeOE5lmu79AcKOawkPpk4PQCsBzNtIEbs=";
                  };

                  cargoHash = "sha256-NnocSs6UkuF/mCM3lIdFk+r51Iz2bHuYzMT/gEbT/nk=";

                  # NOTE: can drop once upstream uses `finalAttrs` here:
                  # https://github.com/NixOS/nixpkgs/blob/10214747f5e6e7cb5b9bdf9e018a3c7b3032f5af/pkgs/build-support/rust/build-rust-package/default.nix#L104
                  #
                  # See (for context): https://github.com/NixOS/nixpkgs/pull/382550
                  cargoDeps = prev.rustPlatform.fetchCargoVendor {
                    inherit (new) src;
                    hash = new.cargoHash;
                    patches = new.cargoPatches or [];
                    name = new.cargoDepsName or new.finalPackage.name;
                  };
                }
              ))
            ]
            ++ lib.optionals prev.stdenv.hostPlatform.isLinux [prev.makeWrapper]
            ++ lib.optionals prev.stdenv.hostPlatform.isDarwin [
              # Provides `ld64.lld` for clang's `-fuse-ld=lld`.
              prev.lld
              prev.rustPlatform.bindgenHook
              (prev.cargo-bundle.overrideAttrs (
                new: old: {
                  version = "0.6.1-zed";
                  src = prev.fetchFromGitHub {
                    owner = "zed-industries";
                    repo = "cargo-bundle";
                    rev = "2be2669972dff3ddd4daf89a2cb29d2d06cad7c7";
                    hash = "sha256-cSvW0ND148AGdIGWg/ku0yIacVgW+9f1Nsi+kAQxVrI=";
                  };
                  cargoHash = "sha256-urn+A3yuw2uAO4HGmvQnKvWtHqvG9KHxNCCWTiytE4k=";

                  # NOTE: can drop once upstream uses `finalAttrs` here:
                  # https://github.com/NixOS/nixpkgs/blob/10214747f5e6e7cb5b9bdf9e018a3c7b3032f5af/pkgs/build-support/rust/build-rust-package/default.nix#L104
                  #
                  # See (for context): https://github.com/NixOS/nixpkgs/pull/382550
                  cargoDeps = prev.rustPlatform.fetchCargoVendor {
                    inherit (new) src;
                    hash = new.cargoHash;
                    patches = new.cargoPatches or [];
                    name = new.cargoDepsName or new.finalPackage.name;
                  };
                }
              ))
            ];
          cargoExtraArgs = "-p zed -p cli --locked --features=gpui_platform/runtime_shaders";
        });
      })
    ];
  };
}
