{
  config,
  lib,
  ...
}: {
  options.myModules.system.xkb.enable =
    lib.mkEnableOption "xkb to de" // {default = true;};

  config = lib.mkIf config.myModules.system.xkb.enable {
    console.keyMap = "de";
    services.xserver.xkb = {
      layout = "de";
      variant = "";
    };
  };
}
