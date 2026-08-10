{
  config,
  lib,
  pkgs,
  ...
}: let
  desktop = config.myModules.desktop;
  sddmSessions = [
    "niri"
    "hyprland"
  ];
in {
  config = lib.mkIf (lib.elem desktop sddmSessions) {
    services.displayManager.defaultSession = desktop;

    services.displayManager.sddm = {
      enable = true;
      package = pkgs.kdePackages.sddm;
      theme = "sddm-astronaut-theme";
      wayland.enable = true;
      extraPackages = with pkgs; [
        kdePackages.qtmultimedia
        kdePackages.qtsvg
        kdePackages.qtvirtualkeyboard
        kdePackages.qtbase
      ];
    };

    environment.systemPackages = [pkgs.sddm-astronaut];
  };
}
