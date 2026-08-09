{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.myModules.system.touchid.enable {
    security.pam.services.sudo_local.touchIdAuth = true;
  };
}
