{ pkgs, ... }: 
{
  programs.rofi = {
    enable = (pkgs.lib.trivial.importJSON ../../profile.json).no_de;
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
