{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    histSize = 8192;
    ohMyZsh.enable = true;
    ohMyZsh.theme = "muse";
    ohMyZsh.plugins = [
      "git"
      "kube-ps1"
      "vi-mode"
      "wd"
    ];

    shellAliases = {
      ip="ip -c";
      tmux="tmux -2";
    };

    interactiveShellInit = ''
      COMPLETION_WAITING_DOTS="true"

      ## Golang
      export GOPATH=$HOME/golang
      export PATH=$PATH:/usr/local/go/bin
      export PATH=$PATH:$GOPATH/bin

      # Vi-mode indicator
      MODE_INDICATOR=" %{$fg_bold[blue]%}%{$reset_color%}"

      # 10ms for key timeout
      KEYTIMEOUT=1

      # FZF
      export FZF_TMUX=1
      export FZF_DEFAULT_OPTS="--border"
      [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

      ## Custom zsh functions
      source ~/.zsh_functions

      # Autocompletion for k8s stuff
      source <(kubectl completion zsh)
      source <(helm completion zsh)

      RPS1='$(kube_ps1)$(vi_mode_prompt_info)'
    '';
  };
}
