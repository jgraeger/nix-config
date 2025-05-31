{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
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
    ../shared/optional/services/greetd.nix
    ../shared/optional/hyprland.nix
    ../shared/optional/1password.nix
 
    # User settings
    ../shared/users/jgraeger
  ];

  hardware = {
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        nvidia-vaapi-driver
      ];
    };
    nvidia = {
      modesetting.enable = true;
      # Try OpenSource drivers
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
      ;
  };

  environment.variables = {
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    NVD_BACKEND = "direct";    
  };

  system.stateVersion = "25.05";
}
