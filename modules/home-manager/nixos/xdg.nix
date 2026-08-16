{
  config,
  lib,
  ...
}: {
  options.myModules.home-manager.programs.xdg.enable =
    lib.mkEnableOption "xdg mimeApps" // {default = true;};

  config = lib.mkIf config.myModules.home-manager.programs.xdg.enable {
    xdg.mimeApps = {
      enable = true;
      defaultApplications = let
        imageViewer = "imv.desktop";
        videoViewer = "mpv.desktop";
        audioViewer = "org.gnome.Decibels.desktop";
        fileViewer = "org.gnome.Nautilus.desktop";
        browser = "zen.desktop";
        textEditor = "codium.desktop";
        chromium = "chromium.desktop";
      in {
        "image/jpeg" = imageViewer;
        "image/png" = imageViewer;
        "image/gif" = browser;
        "image/webp" = imageViewer;
        "image/heif" = imageViewer;
        "text/plain" = textEditor;
        "text/css" = textEditor;
        "application/x-shellscript" = textEditor;
        "application/x-zerosize" = textEditor;
        "text/html" = browser;
        "x-scheme-handler/http" = browser;
        "x-scheme-handler/https" = browser;
        "application/pdf" = browser;
        "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = chromium;
        "audio/mpeg" = audioViewer;
        "inode/directory" = fileViewer;
        "video/mp4" = videoViewer;
        "video/x-matroska" = videoViewer;
        "video/webm" = videoViewer;
        "video/ogg" = videoViewer;
        "video/quicktime" = videoViewer;
        "video/x-flv" = videoViewer;
        "video/x-msvideo" = videoViewer;
        "video/x-ms-wmv" = videoViewer;
        "video/mpeg" = videoViewer;
        "text/x-chdr" = textEditor;
        "text/x-csrc" = textEditor;
        "text/x-c++hdr" = textEditor;
        "text/x-c++src" = textEditor;
      };
    };
  };
}
