{
  description = "Home Manager configuration of Perigord Truffle";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.url = "github:nixos/nixpkgs?rev=fad51abd42ca17a60fc1d4cb9382e2d79ae31836";
    };
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
    ...
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      overlays = [(import ./Overlays/overlay.nix) neovim-nightly-overlay.overlay];
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
