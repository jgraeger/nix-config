{
  config,
  pkgs,
  lib,
  ...  
}:
let
  themes = lib.mapAttrs'
    (name: _: lib.nameValuePair
      (lib.removeSuffix ".toml" name)
      (builtins.fromTOML (builtins.readFile (./themes + "/${name}"))))
    (lib.filterAttrs (name: type: type == "regular" && lib.hasSuffix ".toml" name)
      (builtins.readDir ./themes));
in {
  home.sessionVariables.EDITOR = "hx";
  home.sessionVariables.COLORTERM = "truecolor";

  programs.helix = {
    enable = true;

    settings = {
      theme = "github_dark";
      editor = {
        soft-wrap.enable = true;
      };
    };

    themes = themes;
  };
        
}

