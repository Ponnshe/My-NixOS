{ config, pkgs, scriptsPath, ... }:

{
  programs.zsh = {
    enable = true;

    defaultKeymap = "emacs";

    #Plugins
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    plugins = [
      {
        name = "zsh-completions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-completions";
          rev = "v0.35.0";
          sha256 = "164jw74qlrpl6lawa4wjyhn2d04zw36ac0jsg4r6ql8769kfal8q";
        };
      }
      {
        name = "command-not-found";
        src = pkgs.fetchFromGitHub {
          owner = "ohmyzsh";
          repo = "ohmyzsh";
          rev = "master";  # O usa una versión específica si lo prefieres
          sha256 = "14b2fa510glkck4npmv7dfz8bnis18s7jpf897c63b5gw1ay23va";  # Usa el hash adecuado después de obtenerlo
        };
        file = "plugins/command-not-found/command-not-found.plugin.zsh";
      }
      {
        name = "sudo";
        src = pkgs.fetchFromGitHub {
          owner = "ohmyzsh";
          repo = "ohmyzsh";
          rev = "master";  # O usa una versión específica si lo prefieres
          sha256 = "14b2fa510glkck4npmv7dfz8bnis18s7jpf897c63b5gw1ay23va";  # Usa el hash adecuado después de obtenerlo
        };
        file = "plugins/sudo/sudo.plugin.zsh";
      }
    ];
    # Configuración de History
    history = {
      size = 5000;
      save = 5000;
      #histfile
      ignoreAllDups = true;
      append = true;
      #share = true; Default
      #ignoreSpace = true; Default
      saveNoDups = true;
      #ignoreDups = true; Default
      findNoDups = true;
    };

    # Variables extras
		# export SHELL="/run/current-system/sw/bin/zsh"
    envExtra = ''
        export LS_COLORS=$(dircolors -b)
    '';


    # Configuraciones adicionales
    initContent = ''
      bindkey "^p" history-search-backward
      bindkey "^n" history-search-forward

      zstyle ':completion:*' list-colors "$${(s.:.)LS_COLORS}"
      zstyle ':completion:*' menu no
      zstyle ':fzf-tab:completion:cd:*' fzf-preview 'ls --color $realpath'
      zstyle ':fzf-tab:completion:__zoxide_z:*' fzf-preview 'ls --color $realpath'
      precmd() {
        print -Pn "\e]133;A\e\\"
      }
    '' + builtins.readFile "${scriptsPath}/utils/yazi.sh";
  };
}
