{
  config,
  inputs,
  lib,
  ...
}: {
  
  programs.ssh = {
    enable = true;
    hashKnownHosts = true;
    addKeysToAgent = "true";

    controlMaster = "auto";


    matchBlocks = {
     "git" = {
       host = "github.com gitlab.com";
       user = "git";
       forwardAgent = true;
       identitiesOnly = true;
       identityFile = "/home/jgraeger/.ssh/id_github";
     };
    };

  };

  
}
