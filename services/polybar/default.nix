{ pkgs, ... }: {

  services.polybar = {
    enable = true;
    script = "polybar example &";
    extraConfig = builtins.readFile ./polybarConf;
  };
}
