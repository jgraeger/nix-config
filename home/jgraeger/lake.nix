{pkgs, ...}: {
  imports = [
    ./core

    ./optional/desktops
    ./optional/browsers    
  ];
}
