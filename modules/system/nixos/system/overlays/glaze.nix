{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.myModules.system.overlays.glaze.enable {
    nixpkgs.overlays = [
      (final: prev: {
        hyprland = prev.hyprland.override {
          glaze = prev.glaze.overrideAttrs (old: {
            src = prev.fetchFromGitHub {
              owner = "stephenberry";
              repo = "glaze";
              rev = "v7.9.1";
              hash = "sha256-NRRq5MGF2f5PW0teYnq58ELzson+U6KHVPaY6r30KLA=";
            };
          });
        };
      })
    ];
  };
}
