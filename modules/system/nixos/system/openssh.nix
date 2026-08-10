{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.myModules.system.openssh.enable {
    services.openssh.enable = true;
  };
}
