{
  config,
  lib,
  pkgs,
  ...
}:
{
  wayland.windowManager.hyprland.settings = {
    # =======================
    #  Mouse binds
    # =======================
    bindm = [
      # ALT + leftclick to move/drag active window
      "ALT,mouse:272,movewindow"
      # ALT + rightclick to resize active window
      "ALT,mouse:273,resizewindow"
    ];

    # =======================
    # Binds
    # =======================
    bind =
      let
        workspaces = [
          "F1"
          "F2"
          "F3"
          "F4"
          "F5"
          "F6"
          "F7"
          "F8"
          "F9"
          "F10"
          "F11"
          "F12"
        ];
        directions = rec {
          left = "l";
          right = "r";
          up = "u";
          down = "d";
          h = left;
          l = right;
          k = up;
          j = down;
        };
        pactl = lib.getExe' pkgs.pulseaudio "pactl";
        terminal = config.home.sessionVariables.TERM;
        editor = config.home.sessionVariables.EDITOR;
        
      in
      lib.flatten [

        "ALT,q,killactive"

        # ===================
        #  Quick launcher
        # ===================

        "ALT,space,exec,rofi -show drun"
        "SHIFT_ALT,space,exec,rofi -show run"
        "SUPER,s,exec,rofi -show ssh"
        "ALT,tab,exec,rofi -show window"
        
        "ALT,RETURN,exec,${terminal}"
        "CTRL_ALT,e,exec,${terminal} ${editor}"

        # workspaces
        (map (n: "ALT,${n},workspace,name:${n}") workspaces)
        (map (n: "SHIFT_ALT,${n},movetoworkspace,${n}") workspaces)

        # ===================
        # Session control
        # ===================

        "SHIFTALT,r,exec,hyprctl reload"
        "SUPER,l,exec,hyprlock"
        "SUPER,e,exec,wlogout"
      ];
  };
}
