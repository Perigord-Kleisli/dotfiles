{
  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 11;
    };

    settings = {
      tab_bar_style = "powerline";
      disable_ligatures = "cursor";
      background_opacity = "0.95";
      dynamic_background_opacity = true;
      allow_remote_control = true;

      shell_integration = true;

      color0 = "#000407";
      color8 = "#47526B";
      color1 = "#a22f2f";
      color9 = "#b42525";
      color2 = "#8fc84c";
      color10 = "#5dc42d";
      color3 = "#d8b43f";
      color11 = "#dbe150";
      color4 = "#6589f4";
      color12 = "#284796";
      color5 = "#a383cb";
      color13 = "#9563cb";
      color6 = "#0f94d2";
      color14 = "#3fb0b1";
    };
    keybindings = {
      "kitty_mod+x" = "close_window";
      "kitty_mod+enter" = "launch --cwd=current";
      "kitty_mod+j" = "next_window";
      "kitty_mod+k" = "previous_window";
      "kitty_mod+h" = "move_window_forward";
      "kitty_mod+l" = "move_window_backward";
      "kitty_mod+`" = "move_window_to_top";
      "kitty_mod+r" = "start_resizing_window";
      "kitty_mod+alt+l" = "next_tab";
      "kitty_mod+alt+h" = "previous_tab";
    };
  };
}
