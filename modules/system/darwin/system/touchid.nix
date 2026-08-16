{
  config,
  lib,
  ...
}: {
  options.myModules.system.touchid.enable =
    lib.mkEnableOption "enable touchid" // {default = true;};

  config = lib.mkIf config.myModules.system.touchid.enable {
    security.pam.services.sudo_local.touchIdAuth = true;
  };
}
