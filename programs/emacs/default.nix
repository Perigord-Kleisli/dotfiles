{pkgs, ...}: {
  programs.emacs.enable = true;
  services.emacs.enable = true;

  home.file.".doom.d" = {
    recursive = true;
    source = ./doom.d;
  };
}
