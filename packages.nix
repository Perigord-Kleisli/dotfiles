{pkgs, ...}:
with pkgs; [
  anydesk
  discord
  element-desktop
  inkscape
  gimp
  blender
  libreoffice
  gnome.nautilus

  (nerdfonts.override {fonts = ["JetBrainsMono"];})
  (google-fonts.override {fonts = ["Forum"];})
  raleway-overlay
  liberation_ttf_v1
  etBook
  times-newer-roman

  unclutter
  xclip
  libnotify
  gnuplot

  tldr
  ripgrep
  asciinema
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

  shellcheck
  wakatime

  cbqn

  fennel

  nix-prefetch-github
  statix
  alejandra
  nixfmt
  nil
  deadnix
]
