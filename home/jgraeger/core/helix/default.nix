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
        color-modes = true;
        indent-guides.render = true;
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
      };
    };

    languages = {

      language = [
        {
          name = "nix";
          language-servers = ["nixd" "nil"];
          formatter.command = "alejandra";
        }
      ];

      language-server = {
        nixd = {
          command = "nixd";
        };
        # Typst language server
        tinymist = {
          config = {
            typstExtraArgs = ["main.typ"];
            exportPdf = "onType";
            outputPath = "$root/$name";
          };
        };
      };
      
    };

    themes = themes;
  };
        
}

