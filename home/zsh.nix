{ pkgs, lib, ... }:

let
  inherit (lib) optionalString;
  inherit (pkgs.stdenv) isDarwin isLinux;

  userNameDarwin = "st4nson";
in
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
        "aws"
        "git"
        "kube-ps1"
        "taskwarrior"
        "terraform"
        "vi-mode"
        "wd"
      ];
    };

    shellAliases = {
      cat = "bat";
      sl = "exa";
      ls = "exa";
      la = "exa -la";
      lt = "exa -lasnew";
      mux = "tmuxinator";
      k = "kubectl";
      #ip = "ip --color=auto";
      #tmux="tmux -2";
      st4nson-build = "pushd ~/git/nixfiles/mac; darwin-rebuild build --flake \".#\"; popd";
      st4nson-switch = "NIXPKGS_ALLOW_BROKEN=1 home-manager switch --flake \".#SSzydo\" --impure";
      kube-complete = "source <(kubectl completion zsh)";
    };

    sessionVariables = {
      ZSH_DISABLE_COMPFIX="true";
      COMPLETION_WAITING_DOTS = "true";
      FZF_TMUX = 1;
      GOROOT = "$(go env GOROOT)";
      KEYTIMEOUT = 1;
      PATH = "$PATH:/usr/local/go/bin:$GOPATH/bin:$HOME/bin:$HOME/.krew/bin";
      NIX_PATH = "darwin-config=$HOME/.nixpkgs/darwin-configuration.nix:$HOME/.nix-defexpr/channels:$NIX_PATH";
      KUBE_PS1_CLUSTER_FUNCTION = "cluster_short_name";
      KUBE_PS1_SYMBOL_USE_IMG = "true";
      KUBE_PS1_PREFIX = "";
      KUBE_PS1_SUFFIX = "";
      KUBE_PS1_SEPARATOR= "";
      KUBE_PS1_NS_ENABLE="false";
      KUSTOMIZE_PLUGIN_HOME="$HOME/.config/kustomize/plugin";

      AWS_REGION="us-west-2";
      AWS_PROFILE="nmk-test";
      AWS_PAGER="";
    };

    initExtraFirst = ''
      #zmodload zsh/zprof
    '';

    initExtra = ''
      ## Custom zsh functions
      source ~/.zsh_functions

      ## Autocompletion for k8s stuff - FIXME startup time
      #source <(kubectl completion zsh)
      #source <(helm completion zsh)

      ${optionalString isLinux ''
      # Nord 'dircolors'
      eval $(dircolors ~/.dir_colors)
      ''}

      MODE_INDICATOR=" %{$fg[blue]%}%{$reset_color%}";
      RPS1='$(kube_ps1)|$(aws_custom_prompt)$(vi_mode_prompt_info)'

      ## Needed for single user Nix installation
      #${optionalString isDarwin ''
      #. /Users/${userNameDarwin}/.nix-profile/etc/profile.d/nix.sh
      #''}

      task list
      #zprof
      '';
    };

  home.file.".zsh_functions".source = ../files/zsh_functions;
  home.file.".dir_colors".source = ../files/dir_colors;
}
