{pkgs, ...}: {
  services.picom = {
    enable = true;
    # package = pkgs.picom-next;
    # package = pkgs.picom.overrideAttrs (_: {
    #   src = pkgs.fetchFromGitHub {
    #     owner = "Cobalt-Inferno";
    #     repo = "picom-fork";
    #     rev = "ebf8357402ac0a3184015403dd2170a2ba329675";
    #     hash = "sha256-GA5UjejiROaFlsbEyVWLCD+e2rwxhpb0epwEwZMaqP4=";
    #   };
    # });
    backend = "glx";
    vSync = true;

    shadow = false;
    fade = true;
    fadeDelta = 8;

    fadeExclude = [
      "name = 'XOSD'"
      "name = 'osd_cat'"
      "class_g = 'xborder'"
    ];

    inactiveOpacity = 0.8;
    menuOpacity = 1.0;

    opacityRules = [
      "100:class_g = 'firefox'"
      "100:class_g = 'Rofi'"
    ];

    wintypes = {
      tooltip = {
        fade = true;
        shadow = false;
        opacity = 0.8;
        focus = true;
        full-shadow = false;
      };
      dock = {shadow = false;};
      dnd = {shadow = false;};
      popup_menu = {opacity = 1.0;};
      dropdown_menu = {opacity = 1.0;};
    };
    settings = {
      animations = true;
      mark-wmwin-focused = true;
      mark-ovredir-focused = true;
      detect-rounded-corners = true;
      detect-client-opacity = true;
      corner-radius = 10;
      round-borders = 1;

      blur = {
        method = "dual_kawase";
        strength = 2;
        background-fixed = true;
        kern = "3x3box";
        backgound-exclude = [
          "window_type = 'dock'"
          "window_type = 'desktop'"
          "class_g = 'xborder'"
          "_GTK_FRAME_EXTENTS@:c"
        ];
      };
    };
  };
}
