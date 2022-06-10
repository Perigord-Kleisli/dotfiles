{ pkgs, ... }: {

  services.polybar = {
    enable = (pkgs.lib.trivial.importJSON ../../profile.json).is_minimal;
    script = "polybar example &";
    extraConfig = builtins.readFile ./polybarConf;
  };
}
