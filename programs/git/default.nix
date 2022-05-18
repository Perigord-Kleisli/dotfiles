{pkgs, ...}: {
  programs.git = {
    enable = true;
    userName = "Trouble-Truffle";
    userEmail = "perigordtruffle7318@gmail.com";
    ignores = [
     "*.hie.yaml"
    ];
  };
}
