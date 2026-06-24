{ pkgs, config, ... }:

{
  programs.zsh = {
    enable = true;
    autocd = true;
    dotDir = "${config.home.homeDirectory}/.config/zsh";
    enableCompletion = true;

    oh-my-zsh = {
      enable = true;
      theme = "muse";
      plugins = [
        "aws"
        "git"
        "kube-ps1"
        "vi-mode"
        "wd"
      ];
    };

    shellAliases = {
      cat = "bat";
      sl = "eza";
      ls = "eza";
      la = "eza -la";
      lt = "eza -lasnew";
      mux = "tmuxinator";
      k = "kubectl";
      kube-complete = "source <(kubectl completion zsh)";
      ek = "eval $(envchg k8s)";
      ea = "eval $(envchg aws)";
    };

    sessionVariables = {
      EDITOR="vim";
      ZSH_DISABLE_COMPFIX="true";
      COMPLETION_WAITING_DOTS = "true";
      FZF_TMUX = 1;
      GOROOT = "$(go env GOROOT)";
      KEYTIMEOUT = 1;
      PATH = "$PATH:/usr/local/go/bin:$GOPATH/bin:${config.home.homeDirectory}/bin:${config.home.homeDirectory}/.krew/bin";
      NIX_PATH = "darwin-config=${config.home.homeDirectory}/.nixpkgs/darwin-configuration.nix:${config.home.homeDirectory}/.nix-defexpr/channels:$NIX_PATH";
      KUBE_PS1_CLUSTER_FUNCTION = "cluster_short_name";
      KUBE_PS1_SYMBOL_USE_IMG = "true";
      KUBE_PS1_PREFIX = "";
      KUBE_PS1_SUFFIX = "";
      KUBE_PS1_SEPARATOR= "";
      KUBE_PS1_NS_ENABLE="false";
      KUSTOMIZE_PLUGIN_HOME="${config.home.homeDirectory}/.config/kustomize/plugin";

      AWS_PAGER="";
    };

    initContent = ''
      ## Custom zsh functions
      source ~/.zsh_functions

      ## Lazy-load kubectl and helm completions to improve startup time
      # These completions are only loaded when kubectl or helm is first used
      kubectl() {
        unfunction kubectl 2>/dev/null
        source <(command kubectl completion zsh)
        kubectl "$@"
      }

      helm() {
        unfunction helm 2>/dev/null
        source <(command helm completion zsh)
        helm "$@"
      }

      MODE_INDICATOR=" %{$fg[blue]%}%{$reset_color%}";
      RPS1='$(kube_ps1)|$(aws_custom_prompt)$(vi_mode_prompt_info)'
      '';
    };

  home.file.".zsh_functions".source = ../../dotfiles/zsh/zsh_functions;
}
