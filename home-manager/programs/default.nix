{
  pkgs,
  config,
  ...
}: {
  imports = [./zsh.nix ./git.nix ./firefox.nix ./kitty.nix ./rofi];

  programs = {
    bat = {
      enable = true;
    };

    xmobar.enable = true;
    obs-studio.enable = true;
    lazygit.enable = true;
    readline.enable = true;

    neovim = {
      enable = true;
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
  };
}
