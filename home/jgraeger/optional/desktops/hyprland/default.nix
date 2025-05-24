{
  pkgs,
  config,
  lib,
  ...
}: 
{
  imports = [
    ./binds.nix
    ./hyprlock.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    systemd = {
      enable = true;
      variables = [ "--all" ];
      extraCommands = lib.mkBefore [
        "systemctl --user stop graphical-session.target"
        "systemctl --user start hyprland-session.target"
      ];
    };

    settings = {
      # Environment variables
      env = [
        "NIXOS_OZONE_WL, 1" # for ozone-based and electron apps to run on wayland
        "MOZ_ENABLE_WAYLAND, 1" # for firefox to run on wayland
        "MOZ_WEBRENDER, 1" # for firefox to run on wayland
        "XDG_SESSION_TYPE,wayland"
        "WLR_NO_HARDWARE_CURSORS,1"
        "WLR_RENDERER_ALLOW_SOFTWARE,1"
        "QT_QPA_PLATFORM,wayland"
        "HYPRCURSOR_THEME,rose-pine-hyprcursor" # this will be better than default for now
      ];
    };
  };

}
