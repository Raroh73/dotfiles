{
  description = "Raroh73's dotfiles";

  inputs = {
    agenix = {
      url = "github:ryantm/agenix";
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

  outputs = { self, agenix, home-manager, nixpkgs, nixos-generators, nur }: {
    nixosConfigurations = {
      earth = nixpkgs.lib.nixosSystem rec {
        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
          };
          overlays = [
            nur.overlay
          ];
        };
        system = "x86_64-linux";
        modules = [
          agenix.nixosModules.default
          home-manager.nixosModules.home-manager
          ./hosts/earth/configuration.nix
        ];
      };
      mars = nixpkgs.lib.nixosSystem rec {
        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
          };
        };
        system = "aarch64-linux";
        modules = [
          agenix.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.raroh73.imports = [ ./hosts/mars/home-configuration.nix ];
          }
          ./hosts/mars/system-configuration.nix
        ];
      };
    };
    packages.x86_64-linux = {
      mars-install = nixos-generators.nixosGenerate {
        system = "aarch64-linux";
        modules = [ ./hosts/mars/install-configuration.nix ];
        format = "sd-aarch64";
      };
    };
  };
}
