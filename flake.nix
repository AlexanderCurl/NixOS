{
  description = "NixOS configuration for alexc (sasuke)";

# Force Nix to use these binary caches when evaluating the flake
  nixConfig = {
    extra-substituters = [
      "https://nyx-cache.chaotic.cx"
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nyx-cache.chaotic.cx:dJxTrgMC3V3cFfyIiBQDQorG6k1LsqurH/srpMSq7qk="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dms = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    alexDotfiles = {
      url = "github:AlexanderCurl/Dotfiles";
    };
  };

  outputs = { self, nixpkgs, chaotic, home-manager, dms, ... }@inputs: {
    nixosConfigurations.sasuke = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
         
      specialArgs = { inherit inputs; };
      
      modules = [
        ./configuration.nix
        
        dms.nixosModules.default
        
        chaotic.nixosModules.default

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.users.alexc = import ./home.nix;
        }
      ];
    };
  };
}
