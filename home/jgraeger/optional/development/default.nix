{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: let
  llvm = pkgs.llvmPackages_latest;
in {
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

    # C tools and compiler not opt-in
    gnumake
    cmake
    bear

    clang-tools
    llvm.lldb
    llvm.libstdcxxClang
    llvm.libllvm
    cppcheck
    valgrind
    llvm.libcxx
  ];
}
