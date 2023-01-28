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
  neofetch
  trash-cli
  jq
  rlwrap
  gnumake
  gcc
  nodejs

  antibody

  shellcheck
  nodePackages.cspell
  nodePackages.prettier
  beautysh
  marksman
  wakatime

  cbqn

  sumneko-lua-language-server
  stylua
  fennel
  fnlfmt
  fennel-language-server

  nix-prefetch-github
  statix
  alejandra
  nixfmt
  nil
  deadnix
]
