{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.myModules.programs.desktop-pkgs.enable {
    environment.systemPackages = with pkgs; [
      # core linux
      winetricks
      wine

      # media
      mpv
      vesktop
      easyeffects
      spotify
      imv

      # gaming
      mangohud
      heroic
      prismlauncher
      r2modman

      # web
      chromium

      # creativity
      gimp

      # fun
      asciiquarium-transparent
      cbonsai
      unimatrix

      # misc
      zenity
    ];
  };
}
