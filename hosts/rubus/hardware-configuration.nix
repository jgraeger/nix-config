# hardware-configuration.nix

{ 
  config, 
  lib, 
  pkgs, 
  modulesPath, 
  ... 
}:
{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot = {
    initrd = {
      availableKernelModules = [ "xhci_pci" "usbhid" ];
      kernelModules = [ ];
    };
    kernelModules = [ ];
    extraModulePackages = [ ];
  };

  fileSystems = {
    "/" = { 
      device = "/dev/disk/by-uuid/44444444-4444-4444-8888-888888888888"; # this is important!
      fsType = "ext4";
      options = [ "noatime" ];
    };
  };

  swapDevices = [];

  hardware.raspberry-pi."4" = {
    i2c1.enable = true;
    fkms-3d.enable = true;
  };

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
