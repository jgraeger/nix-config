{
  wayland.windowManager.hyprland.settings = {

    decoration = {
      rounding = 10;
      active_opacity = 1.0;
      inactive_opacity = 0.9;
      fullscreen_opacity = 1.0;

      blur = {
        enabled = true;
        size = 6;
        passes = 2;
        new_optimizations = true;
        ignore_opacity = true;
        xray = true;
      };

      shadow = {
        enabled = true;
        range = 3;
        render_power = 3;
        color = "0x66000000"; 
      };
      
    };
    
  };
}
