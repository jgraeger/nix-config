{
  description = "jgraeger nixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rose-pine-hypercursor = {
      url = "github:ndom91/rose-pine-hyprcursor";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { 
    self, 
    nixpkgs,
    home-manager,
    ... 
  } @ inputs: let
    inherit (self) outputs;
    lib = nixpkgs.lib // home-manager.lib;
  in {
    inherit lib;

    overlays = import ./overlays { inherit inputs outputs; };

    nixosConfigurations = {
      # Desktop workstation
      lake = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [./hosts/lake];
        specialArgs = {
          inherit inputs outputs;
        };
      };

      # Raspberry PI
      rubus = lib.nixosSystem {
        system = "aarch64-linux";
        modules = [./hosts/rubus];
        specialArgs = {
          inherit inputs outputs;
        };
      };

    };
  
  };
}
