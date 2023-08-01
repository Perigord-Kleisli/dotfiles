{
  config,
  pkgs,
  ...
}: {
  programs.rofi = {
    enable = true;
    plugins = with pkgs; [rofi-calc];
    terminal = "${pkgs.kitty}/bin/kitty";
    font = "Roboto 14";
    extraConfig = {
      modi = "drun,run,filebrowser,window";
      case-sensitive = false;
      cycle = true;
      show-icons = true;
    };
  };
}
