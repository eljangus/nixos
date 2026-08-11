{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # core
    ddcutil
    libsForQt5.qt5ct
    gnome-themes-extra
    libnotify
    cabextract # for heroic
    p7zip # for heroic
    hyprpicker
    cliphist
    wl-clipboard
    wl-clip-persist
    kdePackages.kamera
    dconf-editor

    # gaming
    osu-lazer-bin

    # theming
    nwg-look
    adw-gtk3

    # desktop applications
    nautilus
    file-roller
    gnome-clocks
    decibels
    noctalia
  ];
}
