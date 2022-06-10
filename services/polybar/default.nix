{ pkgs, ... }: {

  services.polybar = {
    enable = (pkgs.lib.trivial.importJSON ../../profile.json).isMinimal;
    script = "polybar example &";
    extraConfig = builtins.readFile ./polybarConf;
  };
}
