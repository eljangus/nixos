{
  config,
  pkgs,
  lib,
  ...
}: {
  config = lib.mkIf config.myModules.system.overlays.sddm-astronaut.enable {
    nixpkgs.overlays = [
      (final: prev: {
        sddm-astronaut = prev.sddm-astronaut.override {
          embeddedTheme = "purple_leaves";
        };
      })
    ];
    environment.systemPackages = [pkgs.sddm-astronaut];
  };
}
