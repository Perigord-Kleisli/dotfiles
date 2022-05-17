{ config, pkgs, ... }:

let
  pkgsUnstable = import <nixos-unstable> { };
  userName = "truff";
  homeDir = "/home/${userName}";
in {
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = userName;
  home.homeDirectory = homeDir;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  nixpkgs.overlays = [ ];

  home.file.".doom.d" = {
    recursive = true;
    source = ./doom.d;
  };

  home.file.".xprofile".text = ''
    systemctl start --user polybar.service & kitty &
  '';

  home.packages = with pkgs; [
    pkgsUnstable.discord-canary
    pkgsUnstable.lutris
    discord
    pkgsUnstable.minecraft
    bottles
    steam
    glxinfo
    libgdiplus
    qalculate-gtk
    osu-lazer
    steam-run
    musescore

    (nerdfonts.override { fonts = [ "JetBrainsMono" "FiraMono" ]; })

    libtool
    direnv
    lorri
    niv

    emacs27Packages.vterm
    ripgrep

    libreoffice
    ardour
    blender
    # pkgsUnstable.krita-beta #Errors Compiling
    inkscape
    audacity
    emacs
    libvterm
    kdenlive
    kdeconnect
    gimp
    appimage-run
    obs-studio
    chromium
    handbrake

    bat
    exa
    btop
    fzf
    file
    gnumake
    trash-cli
    yt-dlp
    lazygit
    killall
    unzip
    zoxide
    # vscode

    peek
    picom
    pkgsUnstable.flameshot
    xclip
    dunst
    rofi-calc
    polybar

    ispell
    texlive.combined.scheme-full
    etBook

    cabal2nix
    ghc
    cabal-install
    hlint
    stack
    haskell-language-server
    haskellPackages.ghcup
    haskellPackages.implicit-hie
    haskellPackages.brittany
    haskellPackages.hls-brittany-plugin

    povray

    cargo
    rustc
    rustfmt
    rust-analyzer
    rls

    python
    python3
    python-language-server
    python39Packages.pylint

    shellcheck

    nixfmt
    rnix-lsp
    nix-prefetch-git

    sumneko-lua-language-server

    lxappearance
    gtk4
    gtk3

    zplug
    zsh
    zsh-autosuggestions
    zsh-autopair
    zsh-command-time

    usbutils

    cmake
    cppcheck
    clang-tools

    pkgsUnstable.neovim
    neovide
    # wine
    wine64
    winetricks
    #(wine.override { wineBuild = "wine64"; })
  ];

  fonts.fontconfig.enable = true;

  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 11;
    };
    settings = {
      disable_ligatures = "cursor";
      background_opacity = "0.8";

      color0 = "#000407";
      #color8 = "#14181b";
      color1 = "#a22f2f";
      color9 = "#b42525";
      color2 = "#8fc84c";
      color10 = "#5dc42d";
      color3 = "#d8b43f";
      color11 = "#dbe150";
      color4 = "#6589f4";
      color12 = "#284796";
      color5 = "#a383cb";
      color13 = "#9563cb";
      color6 = "#0f94d2";
      color14 = "#3fb0b1";
    };
    keybindings = {
      "kitty_mod+x" = "close_window";
      "kitty_mod+enter" = "launch --cwd=current";
      "kitty_mod+j" = "next_window";
      "kitty_mod+k" = "previous_window";
      "kitty_mod+h" = "move_window_forward";
      "kitty_mod+l" = "move_window_backward";
      "kitty_mod+`" = "move_window_to_top";
      "kitty_mod+r" = "start_resizing_window";

    };
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    cdpath = [ "~/.local/src" ];
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

    zplug = {
      enable = true;
      plugins = let
        plug = { plugName, repo ? "plugins", tags ? [ "from:oh-my-zsh" ] }: {
          name = "${repo}/${plugName}";
          tags = tags;
        };
      in [
        (plug { plugName = "git"; })
        (plug { plugName = "rust"; })
        (plug { plugName = "zsh-autosuggestions"; })
        (plug { plugName = "zsh-bash"; })
        (plug {
          plugName = "pluginzsh-autopair";
          tags = [ "from:oh-my-zsh" "defer:2" ];
        })
        (plug { plugName = "pluginweb-search"; })
        # (plug { plugName = "plugindirhistory"; })
        (plug { plugName = "pluginzsh-command-time"; })
        (plug {
          plugName = "agnoster";
          repo = "themes";
          tags = [ "from:oh-my-zsh" "as:theme" ];
        })
      ];
    };
    initExtra = ''
      bindkey -e
      bindkey ";5D" backward-word
      bindkey ";5C" forward-word

      WORDCHARS="*?_-.[]~=&;!#$%^(){}<>"

      bindkey "^[[A" history-beginning-search-backward
      bindkey "^[[B" history-beginning-search-forward

      export PATH=$PATH:$HOME/.local/bin/:$HOME/.ghcup/bin/
      eval "$(zoxide init zsh)"
    '';
  };

  programs.firefox = {
    enable = true;
    profiles.default = {
      isDefault = true;

      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };

      userChrome = ''
        #TabsToolbar {
          visibility: collapse;
        }
        #sidebar-header {
          visibility: collapse !important;
        }
      '';
    };

  };

  programs.rofi = {
    enable = true;
    plugins = with pkgs; [ rofi-calc ];
    font = "system-ui 15";
    extraConfig = {
      modi = "window,drun,calc,ssh,combi";
      show-icons = true;
    };
    theme = ./theme.rasi;
  };

  services.picom = {
    enable = true;
    blur = true;
    fade = true;
    shadow = true;
    inactiveOpacity = "0.8";
    vSync = true;
    fadeDelta = 4;
    opacityRule = [ "95:class_i ?= 'rofi'" "100:name *= 'PureRef'" ];
  };

  services.emacs = { enable = true; };
  services.dropbox.enable = true;

  systemd.user.services.polybar = { Unit.After = [ "picom.service" ]; };

  services.polybar = {
    enable = true;
    script = "polybar example &";
    extraConfig = builtins.readFile ./polybarConf;
  };

  programs.git = {
    enable = true;
    userName = "Trouble-Truffle";
    userEmail = "perigordtruffle7318@gmail.com";
  };

  gtk = {
    enable = true;
    theme = {
      name = "Sweet-Dark";
      package = pkgs.sweet;
    };
  };

  services.dunst = {
    enable = true;
    iconTheme = {
      name = "Adwaita";
      package = pkgs.gnome3.adwaita-icon-theme;
      size = "16x16";
    };
    settings = {
      global = {
        monitor = 0;
        geometry = "600x50-50+65";
        shrink = "yes";
        transparency = 10;
        padding = 16;
        horizontal_padding = 16;
        font = "JetBrainsMono Nerd Font 10";
        line_height = 4;
        format = "<b>%s</b>\\n%b";
      };
    };
  };

  home.file.".local/share/applications/PureRef.desktop".text = ''
    [Desktop Entry]
    Name=Pureref
    GenericName=Reference Manager
    Comment=Edit text
    Exec=appimage-run ${homeDir}/.local/bin/PureRef-1.11.1_x64.Appimage %F
    Icon=PureRef
    Type=Application
    Terminal=false
  '';

  home.file.".local/share/applications/emacsclient.desktop".text = ''
    [Desktop Entry]
    Name=Emacsclient
    GenericName=Text Editor
    Comment=Edit text
    MimeType=text/english ;text/plain;text/x-makefile;text/x-c++hdr;text/x-c++src;text/x-chdr;text/x-csrc;text/x-java;text/x-moc;text/x-pascal;text/x-tcl;text/x-tex;application/x-shellscript;text/x-c;text/x-c++;
    Exec=emacsclient -c %F
    Icon=emacs
    Type=Application
    Terminal=false
    Categories=Development;TextEditor;
    StartupWMClass=Emacs
    Keywords=Text;Editor;
  '';

}
