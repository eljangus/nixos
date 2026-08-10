{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: {
  config = lib.mkIf config.myModules.system.overlays.swash.enable {
    nixpkgs.overlays = [
      (final: prev: {
        swash = inputs.swash.packages.${prev.stdenv.hostPlatform.system}.default;
      })
    ];
    environment.systemPackages = [pkgs.swash];
  };
}
