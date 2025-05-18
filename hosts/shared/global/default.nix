# Global settings for all hosts
{
  inputs,
  outputs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./locale.nix
    ./nix.nix
    ./openssh.nix
    ./sops.nix
  ];

  boot.initrd.systemd.enable = true;

  home-manager.useGlobalPkgs = true;
  home-manager.extraSpecialArgs = {
    inherit inputs outputs;
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  networking.domain = "net.graeger.dev";
}
