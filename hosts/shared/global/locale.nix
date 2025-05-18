{lib, ...}: {
  i18n = {
    
    defaultLocale = lib.mkDefault "en_US.UTF-8";
    extraLocaleSettings = {
      LC_TIME = lib.mkDefault "de_DE.UTF-8";
    };
  };
  
  location.provider = "geoclue2";
  time.timeZone = lib.mkDefault "Europe/Berlin";
  services.automatic-timezoned.enable = true;
}
