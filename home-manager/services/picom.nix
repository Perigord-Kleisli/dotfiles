{
  config,
  lib,
  options,
  pkgs,
  ...
}: {
  services.picom = {
    enable = true;
    settings = {
      # animations = true;
      # animation-stiffness = 300.0;
      # animation-dampening = 35.0;
      # animation-clamping = false;
      # animation-mass = 1;
      # animation-for-workspace-switch-in = "slide-left";
      # animation-for-workspace-switch-out = "slide-right";
      # animation-for-open-window = "slide-down";
      # animation-for-menu-window = "none";
      # animation-for-transient-window = "slide-down";
      rounded-corners-exclude = [
        "class_i = 'taffybar'"
        # "class_g = 'i3lock'"
      ];
      shadow = true;
      shadow-radius = 8;
      shadow-opacity = 0.4;
      shadow-offset-x = -8;
      shadow-offset-y = -8;
      fading = true;
      inactive-opacity = 0.8;
      frame-opacity = 0.7;
      inactive-opacity-override = false;
      active-opacity = 1.0;
      focus-exclude = [
      ];

      opacity-rule = [
        "100:class_g = 'i3lock'"
        "60:class_g = 'Dunst'"
        "100:class_g = 'kitty' && focused"
        "90:class_g = 'kitty' && !focused"
      ];

      # blur-kern = "3x3box";
      blur = {
        method = "gaussian";
        strength = 8;
        background = false;
        background-frame = false;
        background-fixed = false;
        kern = "3x3box";
      };

      shadow-exclude = [
        "class_g = 'Dunst'"
      ];

      blur-background-exclude = [
        "class_g = 'Dunst'"
      ];

      backend = "glx";
      vsync = true;
      mark-wmwin-focused = true;
      mark-ovredir-focused = true;
      detect-rounded-corners = true;
      detect-client-opacity = false;
      detect-transient = true;
      detect-client-leader = true;
      use-damage = true;
      log-level = "info";

      wintypes = {
        normal = {
          fade = true;
          shadow = false;
        };
        tooltip = {
          fade = true;
          shadow = false;
          opacity = 0.75;
          focus = true;
          full-shadow = false;
        };
        dock = {shadow = false;};
        dnd = {shadow = false;};
        popup_menu = {opacity = 1.0;};
        dropdown_menu = {opacity = 1.0;};
      };
    };
  };
}
