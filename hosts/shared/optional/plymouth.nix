{
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = [pkgs.adi1090x-plymouth-themes];

  boot = {
    kernelParams = [
      "quiet"
    ];

    plymouth = {
      enable = true;
      theme = "pixels";
      themePackages = [
        (pkgs.adi1090x-plymouth-themes.override {selected_themes = ["pixels"];})
      ];
    };
    consoleLogLevel = 0;
  };
}
