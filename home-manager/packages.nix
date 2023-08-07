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
  gnome.nautilus

  (nerdfonts.override {fonts = ["JetBrainsMono"];})
  (google-fonts.override {fonts = ["Space Grotesk" "Roboto"];})
  source-sans-pro
  nodePackages.grammarly-languageserver
  ispell
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
