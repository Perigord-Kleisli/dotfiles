{pkgs, ...}:
with pkgs; [
  anydesk
  discord
  element-desktop
  inkscape
  gimp
  blender
  gnome.nautilus

  (nerdfonts.override {fonts = ["JetBrainsMono"];})
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
  neofetch
  trash-cli
  jq
  rlwrap
  gnumake
  gcc
  beautysh
  steam-run

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
