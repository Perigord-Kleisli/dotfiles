{ pkgs, ... }: {
  services.picom = {
    enable = true;
    blur = true;
    fade = true;
    shadow = true;
    inactiveOpacity = "0.8";
    vSync = true;
    fadeDelta = 4;
    opacityRule = [ "95:class_i ?= 'rofi'" "100:name *= 'PureRef'" ];
  };
}
