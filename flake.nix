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
          picom = prev.picom.overrideAttrs (_: {
            src = prev.fetchFromGitHub {
              owner = "pijulius"; # This is a fork of picom with animations
              repo = "picom";
              rev = "982bb43e5d4116f1a37a0bde01c9bda0b88705b9";
              sha256 = "YiuLScDV9UfgI1MiYRtjgRkJ0VuA1TExATA2nJSJMhM=";
            };
          });
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
