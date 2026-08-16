{
  config,
  lib,
  ...
}: {
  options.myModules.system.openssh.enable =
    lib.mkEnableOption "enable openssh" // {default = true;};

  config = lib.mkIf config.myModules.system.openssh.enable {
    services.openssh.enable = true;
  };
}
