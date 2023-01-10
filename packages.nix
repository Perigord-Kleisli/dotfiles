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
      krita

      kdenlive # video editor
      #(unable to run on intel hd) pkgsUnstable.davinci-resolve # video editor
      gimp # image editor
      handbrake # Converter tool
    ]
  ]

  #Utils
  [
    qalculate-gtk
    maestral # Dropbox client
    nodePackages.cspell
    wine64
    proton-caller
    pkgsUnstable.samba
    winetricks
    bottles
    steam-run
    dict
    ninja
    rlwrap
    wl-clipboard

    pavucontrol
    helvum
    qjackctl

    dconf
    networkmanagerapplet

    lxappearance # System theme setter/previewer

    #Terminal Tools
    [
      appimage-run
      asciinema
      xclip # x clipboard
      ripgrep # faster grep
      libtool
      jq
      tldr

      pandoc
      nodePackages.live-server

      btop # task manager
      fzf # fuzzy finder
      fd
      file
      trash-cli # rm with recyle bin
      yt-dlp # yt
      nodePackages.pyright
      lazygit # tui git
      git-lfs
      killall
      unzip
      zoxide # smart cd
      hyperfine # benchmarking tool
      usbutils
      obsidian
    ]
  ]

  #Shell
  [
    direnv
    zsh
    zsh-autosuggestions
    zsh-autopair
    zsh-command-time
  ]

  #Fonts
  [
    (nerdfonts.override { fonts = [ "JetBrainsMono" "FiraMono" ]; })
    raleway-overlay
    liberation_ttf_v1
    etBook
    times-newer-roman
  ]

  #Gaming
  [
    steam
    pkgsUnstable.lutris
    # pkgsUnstable.rare
    pkgsUnstable.minecraft
    pkgsUnstable.optifine
    steam
    steam-run
    osu-lazer
  ]

  #Networking/Social
  [
    pkgsUnstable.discord
    element-desktop
    firefox
    chromium
  ]

  #Dev
  [
    qemu
    pkgsUnstable.neovim
    neovide

    #C/C++
    [
      clang
      ccls
      gnumake
      cmake
      cmake-format
      cppcheck
      clang-tools
      lldb
    ]

    #Haskell

    pkgsUnstable.haskell-language-server
    (with haskellPackages; [
      brittany
      alejandra
      cabal2nix
      fast-tags
      cabal-install
      cabal-fmt
      ghc
      hlint
      implicit-hie
      hoogle
      nix-tree
      haskell-dap
      ghci-dap
      haskell-debug-adapter
      stack
    ])

    #Rust
    [
      pkgsUnstable.cargo
      pkgsUnstable.rustc
      pkgsUnstable.clippy
      pkgsUnstable.cargo-nextest
      pkgsUnstable.rust-analyzer
      rustfmt
    ]

    #JS
    [
      nodejs
      pkgsUnstable.node2nix
    ]

    #Python
    [
      black
      jdk
      mypy
      nodePackages.pyright
      poetry
      python
      python3
      python310Packages.flake8
      python310Packages.huggingface-hub
      python310Packages.isort
      python310Packages.pylint
      python310Packages.pytest
    ]

    #Nix
    [
      nixfmt
      nil
      deadnix
      rnix-lsp
      manix
      nix-prefetch-git
      statix
      niv
      lorri
    ]

    #BQN
    [
      cbqn
    ]

    #Lua
    [
      sumneko-lua-language-server
      luajit
      luajitPackages.luacheck
      luajitPackages.luarocks
      stylua
      luajitPackages.fennel
      fennel-language-server
      fennel-ls

      fnlfmt
    ]

    #Others
    [
      idris2
      chez

      shellcheck # for shell languages
      nodePackages.bash-language-server

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
    marksman
    nodePackages.prettier
    libreoffice
  ]

]
