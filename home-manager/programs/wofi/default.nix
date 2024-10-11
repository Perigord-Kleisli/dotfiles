{
  config,
  pkgs,
  ...
}: {
  programs.wofi = {
    enable = true;
    settings = {
      term = "${pkgs.kitty}/bin/kitty";
      insensitive = true;
      allow_images = true;
    };
    style = ''
    * {
      font-family: Roboto;
    }
    '';
  };
}
