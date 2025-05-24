{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.autoLogin;
in
{

  # Custom option for autologin on host
  options.autoLogin = {
    enable = lib.mkEnableOption "Enable autologine";

    username = lib.mkOption {
      type = lib.types.str;
      default = "guest";
      description = "user that should be logged in automatically";
    };    
  };

  config = {
    services.greetd = {
      enable = true;

      restart = true;

      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --asterisks --time --cmd Hyprland";
          user = "jgraeger";  
        };

        initial_session = lib.mkIf cfg.enable {
          command = "${pkgs.hyprland}/bin/Hyprland";
          user = "${cfg.username}";
        };
      }; 
    };
  };
    
}
