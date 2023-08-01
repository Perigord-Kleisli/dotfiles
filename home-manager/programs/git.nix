{ pkgs, lib, ... }:
{
  programs.git = {
    enable = true;
    delta.enable = true;
    userName = "Trouble-Truffle";
    userEmail = "perigordtruffle7318@gmail.com";
    extraConfig.credential.helper = "store";
  };
}
