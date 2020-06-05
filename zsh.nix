{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    autocd = true;
    dotDir = ".config/zsh";
    enableCompletion = true;

    oh-my-zsh = {
      enable = true;
      theme = "muse";
      plugins = [
        "git"
        "kube-ps1"
        "taskwarrior"
        "terraform"
        "vi-mode"
        "wd"
      ];
    };

    shellAliases = {
      sl = "exa";
      ls = "exa";
      la = "exa -la";
      lt = "exa -lasnew";
      ip = "ip --color=auto";
      tmux="tmux -2";
    };

    sessionVariables = {
      COMPLETION_WAITING_DOTS = "true";
      FZF_TMUX = 1;
      GOROOT = "$(go env GOROOT)";
      KEYTIMEOUT = 1;
      MODE_INDICATOR = " %{$fg_bold[blue]%}%{$reset_color%}";
      PATH = "$PATH:/usr/local/go/bin:$GOPATH/bin:$HOME/bin";
    };

    initExtra = ''
      ## Custom zsh functions
      source ~/.zsh_functions

      ## Autocompletion for k8s stuff
      source <(kubectl completion zsh)
      source <(helm completion zsh)

      # Nord 'dircolors'
      eval $(dircolors ~/.dir_colors)

      RPS1='$(kube_ps1)$(vi_mode_prompt_info)'
      task list
      '';
    };

  home.file.".zsh_functions".source = ./files/zsh_functions;
  home.file.".dir_colors".source = ./files/dir_colors;
}
