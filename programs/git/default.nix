{pkgs, ...}: {
  programs.git = {
    enable = true;
    extraConfig = {
      init.defaultBranch = "main";
    };

    userName = "Trouble-Truffle";
    userEmail = "perigordtruffle7318@gmail.com";
    ignores = [
     "*.hie.yaml"
    ];
  };
}
