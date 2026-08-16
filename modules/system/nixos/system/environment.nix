{
  config,
  lib,
  ...
}: {
  options.myModules.system.environment.enable =
    lib.mkEnableOption "general environment stuff I want enabled" // {default = true;};

  config = lib.mkIf config.myModules.system.environment.enable {
    zramSwap.enable = true;
    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      TACK_NIX_CONF_TOKENS = "1";
    };
    documentation.nixos.enable = false;
    services.flatpak.enable = true;
    services.gvfs.enable = true;
  };
}
