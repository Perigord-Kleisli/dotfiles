{ pkgs, ... }: 
{
  programs.rofi = {
    enable = true;
    plugins = with pkgs; [ rofi-calc ];
    terminal = "${pkgs.kitty}/bin/kitty";
    font = "system-ui 14";
    extraConfig = {
      modi = "window,drun,calc,ssh,combi";
      show-icons = true;
    };
    theme = ./theme.rasi;
  };
}
