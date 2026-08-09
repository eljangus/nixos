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
      python3

      # media
      obs-studio
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
      cava
      btop
      asciiquarium-transparent
      cbonsai
      unimatrix

      # misc
      zenity
    ];
  };
}
