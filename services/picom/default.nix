{ pkgs, ... }: 
let 
in{
  services.picom = {
    enable = (pkgs.lib.trivial.importJSON ../../profile.json).no_de;
    # blur = true;
    fade = true;
    shadow = true;
    inactiveOpacity = "0.8";
    vSync = true;
    fadeDelta = 4;
    opacityRules = [ "95:class_i ?= 'rofi'" "100:name *= 'PureRef'" ];
  };
}
