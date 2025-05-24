{ pkgs ? import <nixpkgs> {}, ... }: {
  generateColorscheme = import ./colorschemes/generator.nix {inherit pkgs;};
}
