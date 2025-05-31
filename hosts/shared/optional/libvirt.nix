{
  inputs,
  lib,
  pkgs,
  config,
  ...
}:
let
  virtlib = inputs.nixvirt.lib;
in
{
  imports = [
    inputs.nixvirt.nixosModules.default
  ];
  boot.kernelModules = [ "vfio-pci" ];

  virtualisation.spiceUSBRedirection.enable = true;

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      ovmf = {
        enable = true;
      };
    };
  };
  
  virtualisation.libvirt = {
    enable = true;

    connections."qemu:///system" = {
      
    };
    
  };

  programs.virt-manager.enable = true;

  environment.systemPackages = [
    pkgs.qemu_kvm
    pkgs.qemu
  ];

  users.users.jgraeger = {
    extraGroups = [ "libvirtd" ];
  };
}
