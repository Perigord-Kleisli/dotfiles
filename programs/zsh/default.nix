{ pkgs, ... }: {
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    enableVteIntegration = true;
    autocd = true;

    cdpath = [ "~/.local/src" ];

    zplug = {
      enable = true;
      plugins = let
        plug = { plugName, repo ? "plugins", tags ? [ "from:oh-my-zsh" ] }: {
          name = "${repo}/${plugName}";
          tags = tags;
        };
      in [
        (plug { plugName = "git"; })
        (plug { plugName = "rust"; })
        (plug { plugName = "zsh-autosuggestions"; })
        (plug { plugName = "zsh-bash"; })
        (plug {
          plugName = "pluginzsh-autopair";
          tags = [ "from:oh-my-zsh" "defer:2" ];
        })
        (plug { plugName = "pluginweb-search"; })
        # (plug { plugName = "plugindirhistory"; })
        (plug { plugName = "pluginzsh-command-time"; })
        (plug {
          plugName = "agnoster";
          repo = "themes";
          tags = [ "from:oh-my-zsh" "as:theme" ];
        })
      ];
    };
    initExtra = ''
      bindkey -e
      bindkey ";5D" backward-word
      bindkey ";5C" forward-word
      bindkey "OA" history-beginning-search-backward
      bindkey "OB" history-beginning-search-forward

      WORDCHARS="*?_-.[]~=&;!#$%^(){}<>"


      export PATH=$PATH:$HOME/.local/bin/:$HOME/.ghcup/bin/
      eval "$(zoxide init zsh)"
    '';
  };
}
