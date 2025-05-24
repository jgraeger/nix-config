{ inputs, pkgs, ... }:
{
  programs.hyprland = {
    enable = true;
  };

  environment.systemPackages = [
    inputs.rose-pine-hypercursor.packages.${pkgs.system}.default
  ];
}
