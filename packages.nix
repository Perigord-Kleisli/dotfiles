{pkgs, ...}:
with pkgs; [
  discord
  element-desktop
  inkscape
  krita
  gimp
  blender
  libreoffice
  gnome.nautilus

  (nerdfonts.override {fonts = ["JetBrainsMono"];})
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
  libsForQt5.okular

  unclutter
  xclip
  libnotify
  gnuplot
  exercism

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
]
