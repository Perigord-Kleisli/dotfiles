{pkgs, ...}: {
  programs.rofi = {
    enable = true;
    plugins = with pkgs; [rofi-calc];
    terminal = "${pkgs.kitty}/bin/kitty";
    font = "Roboto 14";
    extraConfig = {
      modi = "window,drun,calc,ssh,combi";
      show-icons = true;
    };
    theme = ./rofi-theme.rasi;
  };
}
