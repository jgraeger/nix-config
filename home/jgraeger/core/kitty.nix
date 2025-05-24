{
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
      selection_foreground = "none";
      selection_background = "none";
    };
    
  };
}

