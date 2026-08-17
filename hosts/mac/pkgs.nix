{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # core
    cava
    btop
    yazi
    p7zip

    # browser
    firefox
  ];
}
