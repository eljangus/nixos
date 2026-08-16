{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # core
    cava
    btop
    yazi

    # browser
    firefox
  ];
}
