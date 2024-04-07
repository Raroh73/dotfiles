{
  description = "Raroh73's dotfiles";

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
    nur.url = "github:nix-community/NUR";
    stylix = {
      url = "github:danth/stylix";
      inputs = {
        home-manager.follows = "home-manager";
        nixpkgs.follows = "nixpkgs";
      };
    };
  };

  outputs = { self, agenix, disko, home-manager, nixpkgs, nur, stylix }: {
    nixosConfigurations = {
      earth = nixpkgs.lib.nixosSystem {
        pkgs = import nixpkgs {
          config.allowUnfree = true;
          overlays = [
            nur.overlay
          ];
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
