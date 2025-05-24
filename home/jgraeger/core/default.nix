{
  inputs,
  lib,
  pkgs,
  config,
  outputs,
  ...
}: {

  imports = [
    ./zsh
      
    ./fonts.nix
    ./git.nix
    ./helix
    ./kitty.nix
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
      SHELL = "zsh";
      TERM = "kitty";
      TERMINAL = "kitty";
      VISUAL = "hx";
      EDITOR = "hx";
    };
  };

  # Packages without config
  home.packages = builtins.attrValues {
    inherit(pkgs)
      btop
      coreutils
      curl
      eza # ls replacement
      dust
      fd
      jq
      ripgrep
      neofetch
      tree
      unzip
      unrar

      nixd # Nix LSP
      alejandra # Nix formatter
      nixfmt-rfc-style
      nix-diff
      nh # Wrapper for nixos and home-manager
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

