{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # core
    cava
    btop

    # browser
    firefox
  ];
}
