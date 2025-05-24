{pkgs, ...}: {
  imports = [
    ./core

    ./optional/desktops
    ./optional/browsers    
  ];

  wallpaper = ../../assets/wallpapers/sunset-lookout.jpg;

  monitors = [
    {
      name = "HDMI-A-1";
      width = 3840;
      height = 2160;
      refreshRate = 60;
      vrr = 1;
      primary = true;

      scale = 1.5;
    }
    {
      name = "DP-1";
      width = 1920;
      height = 1080;
      refreshRate = 60;
      x = 2560;
      transform = 1;
    }
  ];

}
