{inputs, ...}: {

  imports = [
    inputs.hardware.nixosModules.raspberry-pi-4

    ./hardware-configuration.nix

    ../shared/global
    ../shared/users/jgraeger
  ];


  networking = {
    hostName = "rubus";

    vlans.vlan314 = {
      id = 314;
      interface = "end0";
    };
    
    interfaces.vlan314 = {
      useDHCP = false;
      wakeOnLan.enable = true;

      ipv4.addresses = [{
        address = "100.64.10.1";
        prefixLength = 30;
      }];
      ipv6.addresses = [{
        address = "fd00:314::2";
        prefixLength = 64;
      }];
    };

    defaultGateway = {
      address = "100.64.10.2";
      interface = "vlan314";
    };
 
    nameservers = [
      "9.9.9.9"
      "149.112.112.112"
    ];

  };

  services.resolved = {
    enable = true;
    dnssec = "true";
    domains = [ "~." ];
    fallbackDns = [ "9.9.9.9#quad9" "149.112.122.122#quad9" ];
    dnsovertls = "true";
  };

  nix.settings.auto-optimise-store = false;

  services.hardware.argonone.enable = true;

  # Workaround for https://github.com/NixOS/nixpkgs/issues/154163
  nixpkgs.overlays = [
    (_: prev: {makeModulesClosure = x: prev.makeModulesClosure (x // {allowMissing = true;});})
  ];

  system.stateVersion = "25.05";
}
