{
  inputs,
  lib,
  pkgs,
  config,
  ...
}: let
  virtlib = inputs.nixvirt.lib;
in {
  imports = [
    inputs.nixvirt.nixosModules.default
  ];
  boot.kernelParams = ["intel_iommu=on" "iommu=pt" "kvm.ignore_msrs=1"];
  boot.kernelModules = ["vfio-pci" "vfio" "vfio_iommu_type1"];

  virtualisation.spiceUSBRedirection.enable = true;

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      ovmf = {
        enable = true;
      };

      verbatimConfig = ''
        cgroup_device_acl = [
          "/dev/null", "/dev/full", "/dev/zero",
          "/dev/random", "/dev/urandom",
          "/dev/ptmx", "/dev/kvm",
          "/dev/nvidiactl", "/dev/nvidia0", "/dev/nvidia-modeset", "/dev/dri/renderD128"
        ]
      '';
    };
  };

  virtualisation.libvirt = {
    enable = true;

    connections."qemu:///system" = {
    };
  };

  programs.virt-manager.enable = true;

  environment.systemPackages = with pkgs; [
    qemu_kvm
    qemu
    looking-glass-client
  ];

  users.users.jgraeger = {
    extraGroups = [
      "kvm"
      "libvirt"
      "libvirtd"
      "qemu-libvirtd"
      "render"
    ];
  };
}
