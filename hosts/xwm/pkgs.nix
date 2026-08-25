{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # core
    gnome-themes-extra
    libnotify
    cabextract # for heroic
    p7zip # for heroic
    hyprpicker

    # gaming
    osu-lazer-bin

    # theming
    nwg-look
    adw-gtk3

    # desktop applications
    nautilus
    decibels
  ];
}
