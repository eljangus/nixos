{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # core
    cava
    btop
    python3

    # browser
    firefox
  ];
}
