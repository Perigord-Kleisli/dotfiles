{ pkgs, ... }:
let
  onNixos = (pkgs.lib.trivial.importJSON ../profile.json).onNixos;
in {
  xdg = {
    enable = true;
    desktopEntries = (if onNixos then {
      Pureref = {
        name = "Pureref";
        genericName = "Reference Manager";
        comment = "Edit text";
        terminal = false;
        exec = "appimage-run ${
            builtins.getEnv "HOME"
          }/.local/bin/PureRef-1.11.1_x64.Appimage %F";
        icon = "PureRef";
        type = "Application";
      };

      emacsclient = {
        name = "Emacsclient";
        genericName = "Text Editor";
        comment = "Edit text";
        exec = "emacsclient -c %F";
        icon = "emacs";
        type = "Application";
        terminal = false;
        categories = [ "Development" "TextEditor" ];
      };
    } else
      { });
  };

}
