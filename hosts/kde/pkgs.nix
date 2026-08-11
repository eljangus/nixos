{pkgs, ...}: {
  environment = {
    plasma6.excludePackages = with pkgs.kdePackages; [
      konsole
    ];
    systemPackages = with pkgs; [
      # core
      kdePackages.oxygen
      kdePackages.kamera

      # desktop applications
      kdePackages.dolphin
      kdePackages.discover
    ];
  };
}
