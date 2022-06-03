{
  description = "Raroh73's dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
    nurpkgs.url = github:nix-community/NUR;
    nurpkgs.inputs.nixpkgs.follows = "nixpkgs";
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
          home-manager.users.raroh73 = import ./hosts/earth/home/home.nix;
        }
        ./hosts/earth/configuration.nix
      ];
    };
  };
}
