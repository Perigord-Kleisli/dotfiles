{pkgs, ...}: {
  imports = [./picom.nix];
  services = {
    gnome-keyring.enable = true;
    kdeconnect = {
      enable = true;
      indicator = true;
    };

    dunst = {
      enable = true;
    };

    trayer.enable = true;
    flameshot.enable = true;

    emacs = {
      client.enable = true;
      startWithUserSession = true;
      enable = true;
      package = pkgs.emacs-gtk;
    };

    dropbox.enable = true;
  };
}
