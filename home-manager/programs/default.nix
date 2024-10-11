{
  pkgs,
  config,
  pkgs-unstable,
  ...
}: {
  imports = [./zsh.nix ./git.nix ./firefox.nix ./kitty.nix ./wofi];

  programs = {
    bat = {
      enable = true;
    };

    xmobar.enable = true;
    obs-studio = {
      enable = true;
      plugins = [ pkgs.obs-studio-plugins.wlrobs ];
    };

    lazygit.enable = true;
    readline.enable = true;

    neovim = {
      enable = true;
      package = pkgs-unstable.neovim-unwrapped;
      extraLuaPackages = ps: [ ps.magick ];
      defaultEditor = true;
    };

    btop.enable = true;
    fzf = {
      enable = true;
    };
    yt-dlp.enable = true;
    gh = {
      enable = true;
    };

    vscode = {
      enable = true;
      package = pkgs-unstable.vscode;
      extensions =  with pkgs-unstable.vscode-extensions; [
          mikestead.dotenv
          jnoortheen.nix-ide
          christian-kohler.path-intellisense
          ms-dotnettools.csharp
          oderwat.indent-rainbow
        ];
    };
  };
}
