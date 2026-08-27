{
  config,
  lib,
  ...
}: {
  options.myModules.system.environment.enable =
    lib.mkEnableOption "general environment stuff I want enabled" // {default = true;};

  config = lib.mkIf config.myModules.system.environment.enable {
    zramSwap = {
      enable = true;
      algorithm = "zstd";
      priority = 100;
      memoryPercent = 100;
    };
    # TACK_NIX_CONF_TOKENS is set by programs.tack.nixConfTokens (see
    # modules/system/nixos/programs/tack.nix).
    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
    documentation.nixos.enable = false;
    services.flatpak.enable = true;
    services.gvfs.enable = true;
  };
}
