{
  pkgs,
  pkgs-unstable,
  username,
  config,
  ...
}: let
  homeDirectory = "/home/${username}";
in {
  home = {
    inherit username;
    inherit homeDirectory;
    stateVersion = "23.05";
    packages = import ./packages.nix {inherit pkgs pkgs-unstable;};
    sessionVariables = with config.xdg; {
      HISTFILE = "${stateHome}/bash/history";
      CABAL_CONFIG = "${configHome}/cabal/config";
      CABAL_DIR = "${dataHome}/cabal";
      CARGO_HOME = "${dataHome}/cargo";
      GNUPGHOME = "${dataHome}/gnupg";
      GTK2_RC_FILES = "${configHome}/gtk-2.0/gtkrc";
      XCOMPOSECACHE="${cacheHome}/x11/xcompose";
      ERRFILE="${cacheHome}/X11/xsession-errors";
    };
  };

  imports = [./programs ./services ./share];

  programs.home-manager.enable = true;

  fonts.fontconfig.enable = true;

  manual.json.enable = true;

  systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = ["graphical-session-pre.target"];
    };
  };

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };

  xsession = {
    numlock.enable = true;
  };
}
