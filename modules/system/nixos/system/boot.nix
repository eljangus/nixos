{
  pkgs,
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.myModules.system.boot.enable {
    boot = {
      loader.systemd-boot.enable = true;
      loader.efi.canTouchEfiVariables = true;
      kernelPackages = pkgs.linuxPackagesFor (pkgs.linuxKernel.kernels.linux_7_1.override {
        argsOverride = rec {
          src = pkgs.fetchurl {
            url = "mirror://kernel/linux/kernel/v${lib.versions.major version}.x/linux-${version}.tar.xz";
            sha256 = "sha256-IqAZazy83zTcJ7d1YfTQQFhf00R+3JqzUxoax54wQec=";
          };
          version = "7.1.5";
          modDirVersion = "7.1.5";
        };
      });
    };
  };
}
