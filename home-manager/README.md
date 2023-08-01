# Perigord Truffle Dotfiles

# Installation

This configuration requires flakes, to enable add this line to either your `~/.config/nix/nix.conf` or `/etc/nix/nix.conf`
```bash 
experimental-features = nix-command flakes
```
for more info check the [nix flakes page](https://nixos.wiki/wiki/Flakes)

```bash
# Install home-manager, if it's already installed skip this part
# for more detail check their manual (https://nix-community.github.io/home-manager/index.html)
nix-channel --add https://github.com/nix-community/home-manager/archive/release-22.11.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install

cd ~/.config
nix flake clone github:Trouble-Truffle/dotfiles --dest nixpkgs

# The config utilizes my name, change all mentions of 'truff' to $USER.
# ./programs/git.nix Also uses my email, make sure to change that.

# once everything is set do:
home-manager switch --flake ~/.config/nixpkgs#$USER -b backup
# Know that this will install configuration files throughout your system
```
