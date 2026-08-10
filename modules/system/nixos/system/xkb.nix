{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.myModules.system.xkb.enable {
    console.keyMap = "de";
    services.xserver.xkb = {
      layout = "de";
      variant = "";
    };
  };
}
