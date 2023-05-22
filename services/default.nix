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

    status-notifier-watcher.enable = true;

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

  systemd.user.services.status-notifier-watcher = {
    Unit = {
      Description = "SNI watcher";
      After = ["dbus.service"];
    };

    Service = {
      Type = "dbus";
      BusName = "org.kde.StatusNotifierWatcher";
      ExecStart = "${pkgs.haskellPackages.status-notifier-item}/bin/status-notifier-watcher";
    };

    Install.WantedBy = ["default.target"];
  };
}
