{
  description = "NixOS configuration";

  inputs = {
    perigord-greeter.url = "path:/home/truff/.local/src/perigord-greeter";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    devenv.url = "github:cachix/devenv/latest";
    emacs-overlay.url = "github:nix-community/emacs-overlay/da2f552d133497abd434006e0cae996c0a282394";
  };

  outputs = {
    nixpkgs,
    devenv,
    home-manager,
    emacs-overlay,
    perigord-greeter,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      overlays = [
        (import ./overlays)
        (_: _: {
          devenv = devenv.packages.${system}.devenv;
          perigord-greeter = perigord-greeter.packages.${system}.default;
        })
        emacs-overlay.overlay
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
