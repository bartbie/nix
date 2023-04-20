{
  description = "bartbie's Nix system setup";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable"; # nixos-22.11

    # Manages configs links things into your home directory
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Controls system level software and settings including fonts
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ nixpkgs, home-manager, darwin, ... }:
    let
      inherit (darwin.lib) darwinSystem;
    in
    {

      # nix-darwin configs
      darwinConfigurations = {
        Roosevelt = darwinSystem {
          system = "aarch64-darwin";
          pkgs = import nixpkgs { system = "aarch64-darwin"; };
          modules = [
            # nix-darwin setup
            ./modules/darwin
            # home-manager setup
            home-manager.darwinModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                # extraSpecialArgs = { };
                users = {
                  bartosz.imports = [ ./modules/home-manager ];
                };
              };
            }
          ];
        };
      };

    };
}
