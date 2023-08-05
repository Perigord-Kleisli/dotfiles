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

    flameshot.enable = true;

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

  systemd.user.services.maestral-daemon = {
    Unit = {
      Description = "Maestral daemon for the config %i";
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.python310Packages.maestral}/bin/maestral start -f -c %i";
      WatchdogSec = 30;
      ExecStop = "${pkgs.python310Packages.maestral}/bin/maestral stop -c %i";
      ExecStopPost = ''
        ${pkgs.bash}/bin/bash -c "if [ $${SERVICE_RESULT} != success ]; then notify-send Maestral 'Daemon failed: $${SERVICE_RESULT}'; fi"
      '';
      Environment = "PYTHONOPTIMIZE=2 LC_CTYPE=UTF-8";
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
