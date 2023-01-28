{pkgs, ...}: {
  xdg.enable = true;
  qt = {
    enable = true;
    platformTheme = "gtk";
  };

  gtk = {
    enable = true;
    iconTheme = { name = "Mojave CT icons"; };
    theme = {
      name = "Sweet-Dark";
      package = pkgs.sweet;
    };
  };
}
