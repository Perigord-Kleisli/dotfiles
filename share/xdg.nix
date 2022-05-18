{ pkgs, homeDir, ... }: {
  xdg = {
    enable = true;
    desktopEntries = {
      Pureref = {
        name = "Pureref";
        genericName = "Reference Manager";
        comment = "Edit text";
        terminal = false;
        exec =
          "appimage-run ${builtins.getEnv "HOME"}/.local/bin/PureRef-1.11.1_x64.Appimage %F";
        icon = "PureRef";
        type = "Application";
      };

      emacsclient = {
        name = "Emacsclient";
        genericName = "Text Editor";
        comment = "Edit text";
        mimeType = [ "text/english" ];
        exec = "emacsclient -c %F";
        icon = "emacs";
        type = "Application";
        terminal = false;
        categories = [ "Development" "TextEditor" ];
        # startupWMClass = "Emacs";
        # keywords = [ "Text" "Editor" ];
      };
    };
  };

}
