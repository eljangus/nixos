{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkMerge [
    (lib.mkIf config.myModules.system.openrgb.enable {
      services.hardware.openrgb = {
        enable = true;
        package = pkgs.openrgb-with-all-plugins;
        motherboard = "amd";
      };
    })

    (lib.mkIf config.myModules.system.udev.enable {
      services.udev.extraRules = ''
        SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3554", ATTRS{idProduct}=="f523", MODE="0666", TAG+="uaccess"
        SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3554", ATTRS{idProduct}=="f522", MODE="0666", TAG+="uaccess"
        SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3837", ATTRS{idProduct}=="100b", MODE="0666", TAG+="uaccess"
        SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3837", ATTRS{idProduct}=="4019", MODE="0666", TAG+="uaccess"
        SUBSYSTEM=="hidraw", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="ff01", MODE="0666", TAG+="uaccess"
        SUBSYSTEM=="usb", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="ff01", MODE="0666", TAG+="uaccess"
        SUBSYSTEM=="hidraw", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="2402", MODE="0666", TAG+="uaccess"
        SUBSYSTEM=="hidraw", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="ff02", MODE="0666", TAG+="uaccess"
        SUBSYSTEM=="usb", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="ff02", MODE="0666", TAG+="uaccess"
        SUBSYSTEM=="hidraw", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="2403", MODE="0666", TAG+="uaccess"
        SUBSYSTEM=="hidraw", ATTRS{idVendor}=="31e3", MODE="0666", TAG+="uaccess"
        SUBSYSTEM=="usb", ATTRS{idVendor}=="31e3", MODE="0666", TAG+="uaccess"
      '';
    })
  ];
}
