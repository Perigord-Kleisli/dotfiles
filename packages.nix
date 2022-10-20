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

    wine64
    proton-caller
    pkgsUnstable.samba
    winetricks
    bottles
    steam-run
    dict
    rlwrap
    wl-clipboard

    pavucontrol 
    helvum
    qjackctl

    dconf
    networkmanagerapplet

    lxappearance # System theme setter/previewer
    kdeconnect # Connect with other devices

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
    liberation_ttf_v1
    etBook
    times-newer-roman    
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
    pkgsUnstable.discord
    firefox
    chromium
    kdeconnect
  ]

  #Dev
  [
    qemu
    neovim
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
      cabal2nix
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
      manix
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
    nodePackages.markdownlint-cli2
    nodePackages.write-good
    libreoffice
  ]

]
