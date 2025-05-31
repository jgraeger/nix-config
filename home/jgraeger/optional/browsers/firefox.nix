{config, ...}: let
  homeDir = config.home.homeDirectory;
in {
  programs.firefox = {
    enable = true;

    policies = {
      AppAutoUpdate = false;
      BackgroundAppUpdate = false;
      DisableBuiltinPDFViewer = false;
      DisableFirefoxStudies = true;
      DisableFirefoxAccounts = false;
      DisablePocket = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      OfferToSaveLogins = false;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
        EmailTracking = true;
      };
      ExtensionUpdate = false;
    };
    profiles.main = {
      id = 0;
      name = "lake";
      isDefault = true;

      settings = {
        "signon.rememberSignons" = false; # Disable built-in password manager
        "browser.compactmode.show" = true;
        "browser.uidensity" = 1; # enable compact mode
        "browser.aboutConfig.showWarning" = false;
        "browser.download.dir" = "${homeDir}/downloads";

        "browser.tabs.firefox-view" = true; # Sync tabs across devices
        "ui.systemUsesDarkTheme" = 1; # force dark theme
        "extensions.pocket.enabled" = false;
      };

      userChrome = ''
        /* Hide tab bar in FF Quantum */
        @-moz-document url("chrome://browser/content/browser.xul") {
          #TabsToolbar {
            visibility: collapse !important;
            margin-bottom: 21px !important;
          }

          #sidebar-box[sidebarcommand="treestyletab_piro_sakura_ne_jp-sidebar-action"] #sidebar-header {
            visibility: collapse !important;
          }
        }
      '';
    };
  };

  #xdg.mimeApps.defaultApplications = {
  #  "text/html" = ["firefox.desktop"];
  #  "text/xml" = ["firefox.desktop"];
  #  "x-scheme-handler/http" = ["firefox.desktop"];
  #  "x-scheme-handler/https" = ["firefox.desktop"];
  #};
}

