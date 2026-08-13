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
  sddm-astronaut = pkgs.sddm-astronaut.override {embeddedTheme = "purple_leaves";};
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

    environment.systemPackages = [sddm-astronaut];
  };
}
