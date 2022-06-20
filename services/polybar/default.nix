{ pkgs, ... }: {

  services.polybar = {
    enable = (pkgs.lib.trivial.importJSON ../../profile.json).no_de;
    script = "polybar example &";
    extraConfig = builtins.readFile ./polybarConf;
  };
}
