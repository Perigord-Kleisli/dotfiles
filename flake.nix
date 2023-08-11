{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    devenv.url = "github:cachix/devenv/latest";
  };

  outputs = {
    nixpkgs,
    devenv,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      overlays = [
        (import ./overlays)
        (_: prev: {
          devenv = devenv.packages.${system}.devenv;
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
                inherit inputs pkgs;
              };
            };
          }
        ];
      };
    };
  };
}
