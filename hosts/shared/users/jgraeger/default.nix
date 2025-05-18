{
  pkgs,
  config,
  lib,
  ...
}: let
  ifGroupsExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users.mutableUsers = false;
  users.users.jgraeger = {
    isNormalUser = true;
    extraGroups = ifGroupsExist [
      "docker"
      "git"
      "network"
      "wheel"
    ];

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILB8iysu9MthQOEWDSIvr4y+VFTBHowlc47Q43pzrkEq jgraeger@net.graeger.dev"
    ];

    # Bootstrap password
    # hashedPassword = "$y$j9T$cqIK471sMoSuWdaTWd6rU1$WtQDxfO3hfsp0h465BhcbnN9IzYHMKKvQoTYYi1xVz0";
    hashedPasswordFile = config.sops.secrets.jgraeger-password.path;
  };

  sops.secrets = {
    jgraeger-password = {
      sopsFile = ../../secrets.yaml;
      neededForUsers = true;
    };
    "private_keys/github" = {
      sopsFile = ../../secrets.yaml;
      path = "/home/jgraeger/.ssh/id_github";
      mode = "0600";
      owner = "jgraeger";
    };
  };

  home-manager.users.jgraeger = import ../../../../home/jgraeger/${config.networking.hostName}.nix;
}
