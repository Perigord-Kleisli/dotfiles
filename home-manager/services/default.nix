{pkgs, ...}: {
  imports = [./picom.nix];
  services = {
    clipman.enable = true;
    gnome-keyring.enable = true;
    kdeconnect = {
      enable = true;
      indicator = true;
    };

    dunst = {
      enable = true;
      configFile = ./dunstrc;
    };

    status-notifier-watcher.enable = true;
    blueman-applet.enable = true;
    mpris-proxy.enable = true;

    emacs = {
      client.enable = true;
      startWithUserSession = true;
      enable = true;
      package = with pkgs;
        (emacsPackagesFor emacs-gtk).emacsWithPackages (epkgs: [
          epkgs.vterm
        ]);
    };
  };

  systemd.user.services.nm-tray = {
    Unit = {
      Description = "Simple Network Manager frontend written in Qt";
      After = ["tray.target"];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.nm-tray}/bin/nm-tray";
    };
    Install = {
      WantedBy = ["default.target"];
    };
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
