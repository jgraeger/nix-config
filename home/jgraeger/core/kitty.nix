{
  config,
  ...
}:
let
 c = config.colorscheme.colors;
in {
  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;

    settings = {
      font_family = "JetBrainsMono Nerd Font";
      font_size = 12;
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";

      remember_window_size = false;

      cursor_blink_interval = 0.5;
      cursor_stop_blinking_after = 1;

      enable_audio_bell = false;

      window_padding_width = 10;
      hide_window_decorations = true;
      background_opacity = 0.7;
      dynamic_background_opacity = true;
      confirm_os_window_close = 0;

      # Color scheme
      foreground = c.on_surface_variant;
      background = c.surface;
      selection_foreground = c.on_secondary;
      selection_background = c.secondary_fixed_dim;
      url_color = c.primary;

      ## black
      color8 = c.on_surface;
      color0 = c.on_surface_variant;

      ## red
      color1 = c.error;
      color9 = c.error;

      ## green
      color2 = "#94D397";
      color10 = "#94D497";

      ## yellow
      color3 = c.tertiary;
      color11 = c.tertiary;

      ## blue
      color4 = c.secondary;
      color12 = c.secondary;

      ## magenta
      color5 = c.primary;
      color13 = c.primary;

      ## cyan
      color6 = c.tertiary;
      color14 = c.tertiary;

      ## white
      color15 = c.on_surface;
      color7 = c.on_surface;
    };
    
  };
}

