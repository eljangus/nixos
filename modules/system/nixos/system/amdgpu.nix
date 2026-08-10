{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.myModules.system.amdgpu.enable {
    services.xserver.videoDrivers = ["amdgpu"];
  };
}
