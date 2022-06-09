{ config, pkgs, ... }:

let

  osName = with pkgs.lib;
    with builtins;
    let
      file = lists.flatten
        (strings.split "\n" (strings.fileContents /etc/os-release));
      parsedFile = map (x: n: (elemAt (strings.splitString "=" x) n)) file;
      osInfo = head (filter (x: x 0 == "NAME") parsedFile);

    in osInfo 1;

  onNixos = (pkgs.lib.strings.toUpper osName) == "NIXOS";
  isMinimal = builtins.pathExists ./.minimal; # On minimal mode when a .minimal file exists

  pkgsUnstable =
    (if onNixos then import <nixos-unstable> { } else import <unstable> { });

  userName = builtins.getEnv "USER";
  homeDir = builtins.getEnv "HOME";

in {
  programs.home-manager.enable = true;
  nixpkgs.overlays = [ ];

  imports = (import ./programs { inherit onNixos isMinimal; })
    ++ (import ./services { inherit onNixos isMinimal; }) ++ (import ./share);

  targets.genericLinux.enable = !onNixos;

  home = {
    username = userName;
    homeDirectory = homeDir;

    stateVersion = "21.11";
    packages =
      pkgs.callPackage ./packages.nix { inherit pkgs pkgsUnstable isMinimal; };


    file = (if isMinimal then {
      ".xprofile".text = "systemctl start --user polybar.service & kitty &";
      ".local/share/words".source = builtins.fetchurl "https://gist.githubusercontent.com/wchargin/8927565/raw/d9783627c731268fb2935a731a618aa8e95cf465/words";
    } else
      {
      ".local/share/words".source = builtins.fetchurl "https://gist.githubusercontent.com/wchargin/8927565/raw/d9783627c731268fb2935a731a618aa8e95cf465/words";
        });

    shellAliases = {

      ytmp3 = "yt-dlp -f 'ba' -x --audio-format mp3";

      grep = "rg";

      py = "python";

      ls =
        "exa -hF --color=always --icons --sort=size --group-directories-first";
      la =
        "exa -haF --color=always --icons --sort=size --group-directories-first";
      l =
        "exa -lhF --color=always --icons --sort=size --group-directories-first";
      ll =
        "exa -lahF --color=always --icons --sort=size --group-directories-first";
      lst =
        "exa -lahFT --color=always --icons --sort=size --group-directories-first";

      cd = "z";
      ccp = "xclip -sel clip";
      cat = "bat";
      rm = "trash";
      open = "xdg-open";
      icat = "kitty +kitten icat";
      emacs = "emacsclient -c";

    };

    sessionVariables = { NEOVIDE_MULTIGRID = "1"; };
  };

  programs = {
    go.enable = true;
    exa.enable = true;
    gh.enable = true;
    obs-studio.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    bat = {
      enable = true;
      themes = {
        dracula = builtins.readFile (pkgs.fetchFromGitHub {
          owner = "dracula";
          repo = "sublime"; # Bat uses sublime syntax for its themes
          rev = "26c57ec282abcaa76e57e055f38432bd827ac34e";
          sha256 = "019hfl4zbn4vm4154hh3bwk6hm7bdxbr1hdww83nabxwjn99ndhv";
        } + "/Dracula.tmTheme");
      };
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    emacs.enable = onNixos;
  };

  services = {
    emacs.enable = onNixos;
    dropbox.enable = onNixos;
    lorri.enable = true;
    flameshot = {
      enable = isMinimal;
      package = pkgsUnstable.flameshot;
    };
  };

  fonts.fontconfig.enable = true;

  systemd.user.services =
    (if isMinimal then { polybar.Unit.After = [ "picom.service" ]; } else { });
  xdg = { enable = true; };
  qt = {
    enable = true;
    platformTheme = "gtk";
  };

  gtk = {
    enable = true;
    theme = {
      name = "Sweet-Dark";
      package = pkgs.sweet;
    };
  };
}
