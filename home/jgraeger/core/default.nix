{
  inputs,
  lib,
  pkgs,
  config,
  outputs,
  ...
}: {

  imports = [
     ./git.nix
     ./ssh.nix
  ];

  services.ssh-agent.enable = true;

  home = {
    username = lib.mkDefault "jgraeger";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = lib.mkDefault "25.05";
    sessionPath = [
      "$HOME/.local/bin"
    ];
    sessionVariables = {
      FLAKE = "$HOME/nix-config";
    };
  };

  # Packages without config
  home.packages = builtins.attrValues {
    inherit(pkgs)
      coreutils
      curl
      eza # ls replacement
      dust
      jq
      ripgrep
      neofetch
      tree
      unzip
      unrar
      ;
  };

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
        "ca-derivations"
      ];
      warn-dirty = false;
    };  
  };

  programs.home-manager.enable = true;
  
  systemd.user.startServices = "sd-switch";
}

