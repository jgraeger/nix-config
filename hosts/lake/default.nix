{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
let
  iGPUid = "8086:4680";
in {
  imports = [
    # Hardware
    ./hardware-configuration.nix
    inputs.hardware.nixosModules.common-gpu-nvidia
    inputs.hardware.nixosModules.common-pc-ssd

    # SecureBoot
    inputs.lanzaboote.nixosModules.lanzaboote

    # Shared global core
    ../shared/global

    # Optional host modules

    ../shared/optional/audio.nix
    ../shared/optional/libvirt.nix
    ../shared/optional/services/greetd.nix
    ../shared/optional/hyprland.nix
    ../shared/optional/plymouth.nix
    ../shared/optional/1password.nix
 
    # User settings
    ../shared/users/jgraeger
  ];

  # Disable iGPU
  boot = {
    # Prevent intel kernel modules from loading 
    blacklistedKernelModules = [ "snd_hda_intel" "snd_hda_codec_hdmi" "i915" ];
    # Bind iGPU to vfio-pci
    kernelParams = [ "vfio-pci.ids=${iGPUid}" ];
  };
  
  hardware = {
    graphics = {
      enable = true;
    };
    nvidia = {
      modesetting.enable = true;
      # Try OpenSource drivers

      package = config.boot.kernelPackages.nvidiaPackages.latest;
      open = true;
      powerManagement.enable = true;

      prime.offload = { enable = false; };
      prime.sync = { enable = false; };
    };
  };
  services.xserver.videoDrivers = [ "nvidia" ];

  networking = {
    hostName = "lake";
    networkmanager.enable = true;
    enableIPv6 = true;
  };

  boot.bootspec.enable = true;
  boot.loader = {
    # systemd-boot is replaced by lanzaboote
    systemd-boot.enable = lib.mkForce false;
    efi.canTouchEfiVariables = true;
  };
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/etc/secureboot";
  };
  boot.initrd = {
    systemd.enable = true;
  };
  boot.kernelPackages = pkgs.linuxPackages_latest;

  environment.systemPackages = builtins.attrValues {
    inherit (pkgs)
      networkmanagerapplet

      sbctl # secureboot debug and troubleshoot
      vulkan-tools
      libva-utils
      ;
  };

  environment.variables = {
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    NVD_BACKEND = "direct";
  };

  # DualBoot with windows
  time.hardwareClockInLocalTime = true;

  system.stateVersion = "25.05";
}
