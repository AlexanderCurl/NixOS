{
  description = "NixOS configuration for alexc (sasuke)";

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
