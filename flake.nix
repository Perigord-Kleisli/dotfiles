let
  nixosVersion = "24.05";
in 
{
  description = "NixOS configuration";

  inputs = {
    cuphead.url = "gitlab:matthewcroughan/darkflake";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-${nixosVersion}";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-${nixosVersion}";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    eza.url = "github:eza-community/eza";
    devenv.url = "github:cachix/devenv/latest";
  };

  outputs = {
    nixpkgs,
    nixpkgs-unstable,
    devenv,
    fenix,
    home-manager,
    eza,
    cuphead,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs-unstable = import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };
    pkgs = import nixpkgs {
      inherit system;
      overlays = [
        fenix.overlays.default
        (import ./overlays)
        (_: prev: {
          cuphead = cuphead.packages.${system}.cuphead;
          devenv = devenv.packages.${system}.devenv;
          opentabletdriver = pkgs-unstable.opentabletdriver;
          eza = eza.packages.${system}.default;
        })
      ];
      config.allowUnfree = true;
    };
  in {
    nixosConfigurations = {
      "nixos" = nixpkgs.lib.nixosSystem {
        inherit system pkgs;
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              users.truff = import ./home-manager/home.nix;
              extraSpecialArgs = {
                username = "truff";
                inherit inputs pkgs pkgs-unstable;
              };
            };
          }
        ];
      };
    };
  };
}
