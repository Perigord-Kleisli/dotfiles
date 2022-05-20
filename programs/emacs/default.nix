{ pkgs, ... }:
{
  home.file.".doom.d" = {
    recursive = true;
    source = ./doom.d;
  };
}
