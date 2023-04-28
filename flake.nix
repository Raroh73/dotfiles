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
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
  };

  outputs = { self, agenix, home-manager, nixpkgs, nur }: {
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
  };
}
