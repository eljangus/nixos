{
  config,
  pkgs,
  lib,
  self,
  ...
}: {
  config = lib.mkIf config.myModules.system.overlays.qt6ct-kde.enable {
    nixpkgs.overlays = [
      (final: prev: {
        qt6ct-kde = prev.kdePackages.qt6ct.overrideAttrs (old: {
          patches = (old.patches or []) ++ [(self + "/patches/qt6ct-shenanigans.patch")];
          nativeBuildInputs =
            (old.nativeBuildInputs or [])
            ++ [
              prev.kdePackages.kconfig
              prev.kdePackages.kcolorscheme
              prev.kdePackages.kiconthemes
            ];
        });
      })
    ];
    environment.systemPackages = [pkgs.qt6ct-kde];
  };
}
