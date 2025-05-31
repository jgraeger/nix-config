{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./go.nix
  ];

  home.packages = with pkgs; [
    direnv
    delta
    gh
    yq-go
    nmap
    screen
    man-pages
    man-pages-posix
  ];
}
