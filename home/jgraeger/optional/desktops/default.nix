{ pkgs, ... }:
{

  imports = [
    ./hyprland

    ./services/dunst.nix
    ./waybar.nix
    ./rofi.nix
    ./gtk.nix
  ];

  home.packages = [
    pkgs.dconf
    # GUI for pulseaudio and volume
    pkgs.pavucontrol 
    # Wayland copy and paste
    pkgs.wl-clipboard
  ];

}
