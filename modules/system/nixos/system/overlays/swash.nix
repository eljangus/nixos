{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: {
  options.myModules.system.overlays.swash.enable =
    lib.mkEnableOption "swash overlay" // {
      default = config.myModules.system.overlays.enable;
    };

  config = lib.mkIf config.myModules.system.overlays.swash.enable {
    nixpkgs.overlays = [
      (final: prev: {
        swash = inputs.swash.packages.${prev.stdenv.hostPlatform.system}.default;
      })
    ];
    environment.systemPackages = [pkgs.swash];
  };
}
