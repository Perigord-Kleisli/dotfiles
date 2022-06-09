#!/bin/sh
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
      printf "\n\n\x1b[32mNix Installed\xb[0m\n"
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
      nix-env -iA nixpkgs.home-manager
      printf "\n\n\x1b[32mHome-Manager Installed\xb[0m\n"
      ;;
    *)
      exit 1
      ;;
  esac
fi

printf "\x1b[32mCloning Dotfile Repo...\x1b[0m\n"
git clone "https://github.com/Trouble-Truffle/dotfiles.git" "$HOME/.config/nixpkgs"

if [ $? != 0 ]; then
  error "Failed to clone dotfiles repo, check error above and rerun the script"
  exit 1
fi
cd "$HOME/.config/nixpkgs"
if uname -a | grep -qi nixos; then
  onNixos="true"
else
  onNixos="false"
fi
isMinimal="true"

jsonConf() {
  echo "{"
  echo "  \"onNixos\": $1,"
  echo "  \"isMinimal\": $2"
  echo "}"
}
boolSwap() {
  if [ "$1" = "true" ]; then
    echo "yes"
  elif [ "$1" = "false" ]; then
    echo "no"
  else
    echo ""
  fi
}

printf "Create a Dotfile Profile? [Y/N]: "
read -r input
case "$input" in
  [yY][eE][sS]|[yY])

    printf "On NixOS? (default: %s) [Y/N]: " "$(boolSwap "$onNixos")"
    read -r onNixos
    case "$onNixos" in
      [yY][eE][sS]|[yY]) onNixos="true" ;;
      [nN][oO]|[nN])     onNixos="false" ;;
      *)                 ;;
    esac

    printf "Minimal Setup (no DE)? (default: %s) [Y/N]: " "$isMinimal"
    read -r isMinimal 
    case "$isMinimal" in
      [yY][eE][sS]|[yY]) isMinimal="true";;
      [nN][oO]|[nN])     isMinimal="false";;
      *)                 ;;
    esac

    echo "Using profile:"
    printf "\x1b[33m"
    jsonConf "$onNixos" "$isMinimal"
    printf "\x1b[0m"
    jsonConf "$onNixos" "$isMinimal" > profile.json
    ;;
  *)
    echo "Using default profile:"
    jsonConf "$onNixos" "$isMinimal"
    jsonConf "$onNixos" "$isMinimal" > profile.json
    ;;
esac

echo "Setup complete, run 'home-manager switch' to install dotfiles and programs."
