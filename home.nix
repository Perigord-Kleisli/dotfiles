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

  systemd.user.services.mpris-proxy = {
    Unit.Description = "Mpris proxy";
    Unit.After = ["network.target" "sound.target"];
    Service.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
    Install.WantedBy = ["default.target"];
  };

  xsession = {
    numlock.enable = true;
    windowManager.xmonad.enable = true;
  };
}
