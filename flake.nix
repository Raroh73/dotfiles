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
    nurpkgs.url = github:nix-community/NUR;
  };

  outputs = inputs @ { nixpkgs, home-manager, agenix, nurpkgs, ... }: {
    nixosConfigurations.earth = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        agenix.nixosModule
        home-manager.nixosModules.home-manager
        {
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit nurpkgs; };
          home-manager.users.raroh73 = import ./hosts/earth/home.nix;
        }
        ./hosts/earth/configuration.nix
      ];
    };
  };
}
