{
  config,
  lib,
  ...
}: {
  options.myModules.system.amdgpu.enable =
    lib.mkEnableOption "amdgpu video driver" // {default = true;};

  config = lib.mkIf config.myModules.system.amdgpu.enable {
    services.xserver.videoDrivers = ["amdgpu"];
  };
}
