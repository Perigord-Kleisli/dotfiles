{
  services.picom = {
    enable = true;
    activeOpacity = 1;
    inactiveOpacity = 0.65;
    opacityRules = [
      "100:class_g = 'firefox'"
      "100:class_g = 'Rofi'"
    ];
    fade = true;
    fadeDelta = 3;
    vSync = true;
    settings = {
      inactive-dim-exclude = ["window_type = 'Rofi'"];
      mark-overdir-focused = true;
      blur = {size = 10;};
      round-borders = 1;
      corner-radius = 10;
      rounded-corners-exclude = [
        "_NET_WM_WINDOW_TYPE@[0]:a = '_NET_WM_WINDOW_TYPE_DOCK'"
      ];
    };
  };
}
