{
  description = "Home Manager configuration of Perigord Truffle";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    devenv.url = "github:cachix/devenv/latest";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    emacs-overlay.url = "github:nix-community/emacs-overlay/da2f552d133497abd434006e0cae996c0a282394";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    neovim-nightly-overlay,
    emacs-overlay,
    devenv,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      overlays = [
        (import ./Overlays/overlay.nix)
        (self: super: {devenv = devenv.packages.${system}.devenv;})
        neovim-nightly-overlay.overlay
        emacs-overlay.overlay
      ];
      config.allowUnfree = true;
    };
    username = "truff";
  in {
    homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      modules = [./home.nix];
      extraSpecialArgs = {
        inherit username;
      };
    };
  };
}
