{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.myModules.programs.desktop-pkgs.enable {
    environment.systemPackages = with pkgs; [
      # core
      tack

      # media
      vesktop

      # theming
      pywalfox-native
    ];
  };
}
