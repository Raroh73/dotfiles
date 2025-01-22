{
  description = "My personal dotfiles.";

  inputs = {
    agenix = {
      url = "github:ryantm/agenix";
      inputs = {
        home-manager.follows = "home-manager";
        nixpkgs.follows = "nixpkgs";
      };
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    #nixpkgs.url = "/home/raroh73/nixpkgs";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      agenix,
      disko,
      home-manager,
      nixpkgs,
      nur,
    }:
    {
      nixosConfigurations = {
        earth = nixpkgs.lib.nixosSystem {
          pkgs = import nixpkgs {
            config = {
              allowUnfree = true;
              # https://github.com/NixOS/nixpkgs/issues/375745
              #rocmSupport = true;
            };
            overlays = [ nur.overlays.default ];
            system = "x86_64-linux";
          };
          modules = [
            agenix.nixosModules.default
            #disko.nixosModules.disko
            home-manager.nixosModules.home-manager
            ./hosts/earth/configuration.nix
          ];
          system = "x86_64-linux";
        };
      };
    };
}
