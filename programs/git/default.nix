{pkgs, ...}: 
{
  programs.git = {
    enable = true;
    extraConfig = {
      init.defaultBranch = "main";
    };

    userName = (pkgs.lib.trivial.importJSON ../../profile.json).git_name;
    userEmail = (pkgs.lib.trivial.importJSON ../../profile.json).git_email;
    lfs = { enable = true; };
    extraConfig = {
      credential = {helper = "store";};
    };
    ignores = [
     "*.hie.yaml"
    ];
  };
}
