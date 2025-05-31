{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.go = {
    enable = true;
  };

  home.packages = with pkgs; [
    gopls
    golangci-lint
    delve
    gotools
  ];

  home.sessionVariables = {
    GOROOT = "${pkgs.go}/share.go";
  };

  home.sessionPath = [
    "$GOPATH/bin"
  ];
}
