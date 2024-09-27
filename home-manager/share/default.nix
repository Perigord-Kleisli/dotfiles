{
  pkgs,
  config,
  ...
}: {
  xdg = {
    enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = {
        "text/html" = "firefox.desktop";
        "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = "writer.desktop";
      };
    };
    desktopEntries = {
      "PureRef" = {
        type = "Application";
        terminal = false;
        name = "PureRef";
        icon = ./data/PureRef.png;
        exec = let
          pureRef = pkgs.requireFile {
            name = "PureRef-2.0.3_x64.Appimage";
            sha256 = "1wrm81l5gg6b4gjsl74q2hhfdxigp85064dcm2bgarmczmq7a96j";
            url = "https://www.pureref.com/download.php";
          };
        in "${pkgs.appimage-run}/bin/appimage-run ${pureRef}";
      };
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    font = {
      name = "Noto Sans";
      package = pkgs.noto-fonts;
      size = 10;
    };

    theme = {
      name = "palenight";
      package = pkgs.palenight-theme;
    };

    cursorTheme = {
      name = "Numix-Cursor";
      package = pkgs.numix-cursor-theme;
    };

    gtk2 = {
      configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
      extraConfig = ''
        gtk-enable-animation = 1;
      '';
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  home.sessionVariables.GTK_THEME = "palenight";
}
