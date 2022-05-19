{ pkgs, ... }:
let
  osName = with pkgs.lib;
    with builtins;
    let
      file = (strings.split "\n" (strings.fileContents /etc/os-release));

      parsedFile =
        map (x: n: (elemAt (strings.splitString "=" x) n)) (lists.flatten file);

    in (head (filter (x: x 0 == "NAME") parsedFile)) 0;

  onNixos = (pkgs.lib.strings.toUpper osName) == "NIXOS";
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
