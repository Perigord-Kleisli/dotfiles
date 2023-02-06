{
  pkgs,
  username,
  ...
}: let
  homeDirectory = "/home/${username}";
in {
  home = {
    inherit username;
    inherit homeDirectory;
    stateVersion = "22.11";
    packages = import ./packages.nix {inherit pkgs;};
  };

  imports = [./programs ./services ./share];

  programs.home-manager.enable = true;

  fonts.fontconfig.enable = true;

  manual.json.enable = true;

  xsession = {
    numlock.enable = true;
    windowManager.xmonad.enable = true;
  };
}
