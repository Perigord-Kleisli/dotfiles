{pkgs, ...}: {
  programs.exa.enable = true;
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.command-not-found.enable = true;

  programs.zsh = {
    history.expireDuplicatesFirst = true;

    enable = true;
    enableSyntaxHighlighting = true;

    enableVteIntegration = true;
    autocd = true;

    dotDir = ".config/zsh";

    shellAliases = {
      ytmp3 = "${pkgs.yt-dlp}/bin/yt-dlp -f 'ba' -x --audio-format mp3";

      grep = "rg";

      py = "python";

      ls = "${pkgs.exa}/bin/exa -hF --color=always --icons --sort=size --group-directories-first";
      la = "${pkgs.exa}/bin/exa -haF --color=always --icons --sort=size --group-directories-first";
      l = "${pkgs.exa}/bin/exa -lhF --color=always --icons --sort=size --group-directories-first";
      ll = "${pkgs.exa}/bin/exa -lahF --color=always --icons --sort=size --group-directories-first";
      lst = "${pkgs.exa}/bin/exa -lahFT --color=always --icons --sort=size --group-directories-first";
      mkignore = "forgit::ignore";

      cd = "z";
      ccp = "xclip -sel clip";
      cat = "${pkgs.bat}/bin/bat";
      rm = "${pkgs.trash-cli}/bin/trash";
      open = "xdg-open";
      icat = "kitty +kitten icat";
    };

    enableAutosuggestions = true;
    enableCompletion = true;
    completionInit = ''
      autoload -U +X compinit && compinit
      autoload -U +X bashcompinit && bashcompinit
      zstyle ":completion:*" matcher-list "" "m:{a-zA-Z}={A-Za-z}"
    '';

    sessionVariables = {
      NEOVIDE_MULTIGRID = "true";
      AUTO_NOTIFY_IGNORE = import ./auto-notify-ignore.nix;
      EDITOR = "${pkgs.neovim}/bin/nvim";
    };

    zplug = {
      enable = true;
      plugins = [
        {
          name = "~/.config/nixpkgs/programs";
          tags = ["as:theme" "use:perigord.zsh-theme" "from:local"];
        }
        {name = "MichaelAquilina/zsh-auto-notify";}
        {
          name = "hlissner/zsh-autopair";
          tags = ["defer:2"];
        }
        {name = "ael-code/zsh-colored-man-pages";}
        {name = "wfxr/forgit";}
        {name = "coot/zsh-haskell";}
      ];
    };

    initExtra = ''

      export XDG_DATA_DIRS="$XDG_DATA_DIRS:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share"

      autoload -U history-search-end
      zle -N history-beginning-search-backward-end history-search-end
      zle -N history-beginning-search-forward-end history-search-end

      bindkey -e
      bindkey ";5D" backward-word
      bindkey ";5C" forward-word
      bindkey \^u backward-kill-line
      bindkey "^[[A" history-beginning-search-backward-end
      bindkey "^[[B" history-beginning-search-forward-end
      bindkey \^h backward-word
      bindkey \^l forward-word
      bindkey \^j history-search-forward
      bindkey \^k history-search-backward

      WORDCHARS="*?_-.[]~=&;!#$%^(){}<>"
      export PATH=$PATH:$HOME/.local/bin/
      eval "$(zoxide init zsh)"
      # eval "$(idris2 --bash-completion-script idris2)"

      function plot {
      cat <<HEREDOC | gnuplot
          set terminal pngcairo enhanced font 'Fira Sans,10'
          set autoscale
          set samples 1000
          set output '|kitty +kitten icat --stdin yes'
          set object 1 rectangle from screen 0,0 to screen 1,1 fillcolor rgb"#fdf6e3" behind
          plot $@
          set output '/dev/null'
      HEREDOC
      }

      function run() {
        nix-shell -p "$1" --run "$*"
      }
    '';
  };
}
