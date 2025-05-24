{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.zsh = {
    enable = true;

    dotDir = ".config/zsh";
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autocd = true;
    autosuggestion.enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "sudo"
      ];
    };

    shellAliases = {

      # Navigation
      l = "eza -lah";
      la = "eza -lah";
      ll = "eza -lh";
      ls = "eza";
      lsa = "eza -lah";
    
      # SSH
      ssh = "TERM=xterm ssh";

    };
  };
}
