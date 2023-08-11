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
    stateVersion = "23.05";
    packages = import ./packages.nix {inherit pkgs;};
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
