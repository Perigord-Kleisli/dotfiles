{pkgs, ...}:
with pkgs; [
  bitwarden-cli
  discord
  element-desktop
  inkscape
  krita
  gimp
  blender
  libreoffice
  vscode
  graphviz
  gnome.nautilus
  wineWowPackages.stable
  eza

  (nerdfonts.override {fonts = ["JetBrainsMono" "Iosevka"];})
  (google-fonts.override {fonts = ["Space Grotesk" "Roboto" "Bebas Neue"];})
  source-sans-pro
  feather
  nodePackages.grammarly-languageserver
  ispell
  iosevka
  raleway-overlay
  liberation_ttf_v1
  etBook
  times-newer-roman
  texlive.combined.scheme-full
  imagemagick
  qalculate-gtk
  libqalculate
  libsForQt5.okular

  unclutter
  xclip
  libnotify
  gnuplot
  ((emacsPackagesFor emacs-gtk).emacsWithPackages
    (epkgs: [
      epkgs.vterm
    ]))
  exercism
  sqlite

  zoom-us
  qemu
  virt-manager
  gtk-engine-murrine
  gtkmm4
  gtkmm3
  drawio

  tldr
  zip
  ripgrep
  asciinema
  unzip
  fd
  grex
  neofetch
  trash-cli
  jq
  rlwrap
  gnumake
  python39
  gcc
  beautysh
  steam-run
  neovide
  maestral
  maestral-gui

  antibody
  acpi

  shellcheck
  appimage-run
  wakatime

  cbqn

  fennel

  nix-prefetch-github
  statix
  alejandra
  nixfmt
  nil
  deadnix
  devenv

  marksman
  nodePackages.cspell
  nodejs
  gpick
  wordnet
  xorg.xmodmap

  swaynotificationcenter
  wl-clipboard
  killall
  feh
  dunst

  usbutils
]
