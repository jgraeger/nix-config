{
  pkgs,
  ...
}:
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;

    extraConfig = {
      show-icons = true;

      drun-match-fields = "name";
      drun-display-format = "{name}";
      
    };
  };
}
