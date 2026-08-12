{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  zenPackages = inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system};

  prefs = {
    "extensions.autoDisableScopes" = 0;
    "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
    "devtools.chrome.enabled" = true;
    "browser.aboutConfig.showWarning" = false;
    "browser.shell.checkDefaultBrowser" = false;
    "browser.newtabpage.activity-stream.showSponsored" = false;
    "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
    "browser.urlbar.suggest.quicksuggest.sponsored" = false;
    "datareporting.healthreport.uploadEnabled" = false;
    "toolkit.telemetry.enabled" = false;
    "toolkit.telemetry.unified" = false;
    "media.ffmpeg.vaapi.enabled" = true;
    "zen.theme.content-element-separation" = 0;
    "zen.window-sync.enabled" = false;
  };

  zen = pkgs.wrapFirefox zenPackages.zen-browser-unwrapped {
    pname = "zen-browser";
    extraPrefs = lib.concatLines (
      lib.mapAttrsToList (
        name: value: "defaultPref(${builtins.toJSON name}, ${builtins.toJSON value});"
      )
      prefs
    );
    extraPolicies = {
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
      SearchEngines = {
        Default = "DuckDuckGo";
      };
    };
  };
in {
  config = lib.mkIf config.myModules.programs.zen.enable {
    environment.systemPackages = [zen];
  };
}
