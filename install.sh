#!/usr/bin/env bash
error() {
  printf "\x1b[31mError: %s\x1b[0m\n" "$1"
}

if [ ! -x "$(command -v nix-env)" ]; then
  printf "'nix-env' not found, Install Nix? [Y/N]: "
  read -r input
  case "$input" in
    [yY][eE][sS]|[yY])
      menu=0
      while [ "$menu" != 1 ]; do

        echo "Choose Install method: "
        printf "\x1b[32m[1]\x1b[0m Multi-User Installation: \x1b[33m'sh <(curl -L https://nixos.org/nix/install) --daemon'\x1b[0m\n"
        printf "\x1b[32m[2]\x1b[0m Single-User Installation: \x1b[33m'sh <(curl -L https://nixos.org/nix/install) --no-daemon'\x1b[0m\n"
        printf "\x1b[32m[3]\x1b[0m More Info\n"
        read -r input
        case "$input" in
          1)
            sh <(curl -L https://nixos.org/nix/install) --daemon
            menu=1
            ;;
          2)
            sh <(curl -L https://nixos.org/nix/install) --no-daemon
            menu=1
            ;;
          3)
            xdg-open "https://nixos.org/download.html"
            ;;
          "debug")
            menu=1
            ;;
          *)
            error "Invalid Input"
            ;;
        esac
      done
      if [ $? != 0 ]; then
        error "Failed to install Nix, check error above and rerun this script"
    exit 1
      fi
      printf "\n\n\x1b[32mNix Installed\x1b[0m\n"
      echo "Please restart your terminal and rerun this script"
      exit 0
      ;;
    *)
      ;;
  esac
fi

if [ ! -x "$(command -v home-manager)" ]; then
  printf "Install home-manager? [Y/N]: "
  read -r input
  case "$input" in
    [yY][eE][sS]|[yY])
      nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
      nix-channel --update
      echo "export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}" > .bashrc
      
      printf "\n\n\x1b[32mHome-Manager Installed\x1b[0m\n"
      if ! nix-shell '<home-manager>' -A install ; then
        error "Failed to install home-manager, check error above and rerun the script"
        exit 1
      fi
      ;;
    *)
      exit 1
      ;;
  esac
fi

printf "\x1b[32mCloning Dotfile Repo...\x1b[0m\n"


if ! git clone "https://github.com/Trouble-Truffle/dotfiles.git" "$HOME/.config/nixpkgs" ; then
  error "Failed to clone dotfiles repo, check error above and rerun the script"
  exit 1
fi

printf "\x1b[32mInstalling unstable channel\x1b[0m\n"
nix-channel --add https://nixos.org/channels/nixpkgs-unstable unstable
nix-channel --update


cd "$HOME/.config/nixpkgs" || exit

echo "Setting up Profile: "
bash jsonProfile.sh

echo "Setup complete, run 'home-manager switch' to install dotfiles and programs."
