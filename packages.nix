{ pkgs, pkgsUnstable, isMinimal }:
with pkgs;
lib.lists.flatten [

  #Creative
  [
    #Music
    [
      ardour # DAW
      audacity # Audio recorder and editor
      yabridge # VST Bridge
      yabridgectl
      musescore # Music Notation

      zyn-fusion
    ]

    #Visual
    [
      blender # 3d Modelling
      inkscape # SVG
      #(unable to be built) pkgsUnstable.krita # Digital painting

      kdenlive # video editor
      #(unable to run on intel hd) pkgsUnstable.davinci-resolve # video editor
      gimp # image editor
      handbrake # Converter tool
    ]
  ]

  #Utils
  [
    qalculate-gtk

    wine
    proton-caller
    pkgsUnstable.samba
    winetricks
    bottles
    steam-run

    pavucontrol 
    helvum
    qjackctl

    lxappearance # System theme setter/previewer
    kdeconnect # Connect with other devices

    #Terminal Tools
    [
      appimage-run
      asciinema
      xclip # x clipboard
      ripgrep # faster grep
      libtool
      btop # task manager
      fzf # fuzzy finder
      fd
      trash-cli # rm with recyle bin
      yt-dlp # yt
      lazygit # tui git
      killall
      unzip
      zoxide # smart cd
      hyperfine #benchmarking tool
      usbutils
    ]
  ]

  #Shell
  [
    direnv

    zplug
    zsh
    zsh-autosuggestions
    zsh-autopair
    zsh-command-time
  ]

  #Fonts
  [
    (nerdfonts.override { fonts = [ "JetBrainsMono" "FiraMono" ]; })
    #(doesnt work with zplug) raleway
    etBook
  ]

  #Gaming
  [
    steam
    pkgsUnstable.lutris
    pkgsUnstable.rare
    pkgsUnstable.minecraft
    pkgsUnstable.optifine
    steam
    steam-run
    osu-lazer
  ]

  #Networking/Social
  [
    discord
    firefox
    chromium
    kdeconnect
  ]

  #Dev
  [
    pkgsUnstable.neovim
    neovide

    #C/C++
    [
      gnumake
      cmake
      cmake-format
      cppcheck
      clang-tools
    ]

    #Haskell 

    pkgsUnstable.haskell-language-server
    (with haskellPackages; [
      brittany
      cabal2nix
      cabal-install
      cabal-fmt
      ghc
      hlint
      implicit-hie
      hoogle
      nix-tree
    ])

    #Rust
    [
      cargo
      rustc
      rustfmt
      rust-analyzer
      rls
    ]

    #JS
    [
      nodejs
      pkgsUnstable.node2nix
    ]

    #Python
    [
      python
      python3
      #(Errors on non-Nixos distros) python-language-server
      python39Packages.pylint
    ]

    #Nix
    [
      nixfmt
      rnix-lsp
      nix-prefetch-git
      statix
      niv
      lorri
    ]

    #Lua
    [
      sumneko-lua-language-server
      luajit
      luajitPackages.luacheck
      luajitPackages.luarocks
      stylua

      fennel
      fnlfmt
    ]

    #Others
    [
      shellcheck # for shell languages

      tree-sitter

      sbcl # Steel Bank common lisp
      lispPackages.quicklisp # Common lisp package manager

      asmfmt

      texlive.combined.scheme-full # latex
    ]
  ]

  #Writting
  [
    ispell
    nodePackages.markdownlint-cli2
    nodePackages.write-good
    libreoffice
  ]

]
