{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: let 
  
  publicKey = "/home/jgraeger/.ssh/id_github";  

in {

  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;

    # TODO: Move this into a development module
    userName = "Johannes Gräger";
    userEmail = "jgraeger@posteo.de";
    
    extraConfig = {
      core.editor = "hx";
      
      log.showSignature = "true";
      init.defaultBranch = "main";
      pull.rebase = "true";

      commit.gpgsign = true;
      gpg.format = "ssh";
      user.signingKey = publicKey;

    };

    signing = {
      signByDefault = true;
      key = publicKey;
    };


  };

}
