{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  zen = inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.beta.override {
    # https://mozilla.github.io/policy-templates/
    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DontCheckDefaultBrowser = true;

      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "normal_installed";
          private_browsing = true;
        };
      };

      Preferences = lib.mapAttrs (_: value: {
        inherit value;
        Status = "default";
      }) {
        "extensions.autoDisableScopes" = 0;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "browser.aboutConfig.showWarning" = false;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.urlbar.suggest.quicksuggest.sponsored" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "media.ffmpeg.vaapi.enabled" = true;
      };
    };
  };
in {
  config = lib.mkIf config.myModules.programs.zen.enable {
    home.packages = [zen];
  };
}