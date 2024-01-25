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
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
  };

  outputs = { self, agenix, disko, home-manager, nixpkgs, nixos-generators, nur }: {
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
      /* mars = nixpkgs.lib.nixosSystem {
        pkgs = import nixpkgs {
          config.allowUnfree = true;
          system = "aarch64-linux";
        };
        modules = [
          agenix.nixosModules.default
          home-manager.nixosModules.home-manager
          ./hosts/mars/configuration.nix
        ];
        system = "aarch64-linux";
      }; */
      sirius = nixpkgs.lib.nixosSystem {
        pkgs = import nixpkgs {
          config.allowUnfree = true;
          system = "aarch64-linux";
        };
        modules = [
          agenix.nixosModules.default
          disko.nixosModules.disko
          home-manager.nixosModules.home-manager
          ./hosts/sirius/configuration.nix
        ];
        system = "aarch64-linux";
      };
    };
    packages.x86_64-linux = {
      mars-install = nixos-generators.nixosGenerate {
        format = "sd-aarch64";
        modules = [ ./hosts/mars/install-configuration.nix ];
        system = "aarch64-linux";
      };
    };
  };
}
