{
  config,
  lib,
  pkgs,
  ...
}: {
  options.myModules.programs.desktop-pkgs.enable =
    lib.mkEnableOption "enable desktop packages" // {default = true;};

  config = lib.mkIf config.myModules.programs.desktop-pkgs.enable {
    environment.systemPackages = with pkgs; [
      # core
      tack

      # theming
      pywalfox-native
    ];
  };
}
