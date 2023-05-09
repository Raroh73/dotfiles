{
  description = "Raroh73's dotfiles";

  inputs = {
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    deploy-rs = {
      url = "github:serokell/deploy-rs";
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

  outputs = { self, agenix, deploy-rs, home-manager, nixpkgs, nixos-generators, nur }: {
    nixosConfigurations.earth = nixpkgs.lib.nixosSystem {
      pkgs = (import nixpkgs) {
        system = "x86_64-linux";
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
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.raroh73.imports = [ ./hosts/earth/home-configuration.nix ];
        }
        ./hosts/earth/system-configuration.nix
        ./hosts/earth/hardware-configuration.nix
      ];
    };
    nixosConfigurations.mars = nixpkgs.lib.nixosSystem {
      pkgs = (import nixpkgs) {
        system = "aarch64-linux";
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
    deploy.nodes = {
      earth = {
        hostname = "earth";
        profiles.system = {
          user = "root";
          path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.earth;
        };
      };
      mars = {
        hostname = "mars";
        profiles.system = {
          user = "root";
          path = deploy-rs.lib.aarch64-linux.activate.nixos self.nixosConfigurations.mars;
        };
      };
    };
    checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;
    packages.x86_64-linux = {
      mars-install = nixos-generators.nixosGenerate {
        system = "aarch64-linux";
        modules = [ ./hosts/mars/install-configuration.nix ];
        format = "sd-aarch64";
      };
    };
  };
}
