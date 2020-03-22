{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    ansible-lint
    ansible_2_7
    cfssl
    gopass
    openconnect
    redshift
    taskwarrior

    docker-compose
    docker-ls
    docker-machine

    chromium
    firefox
    icedtea8_web
    keepassxc
    libreoffice
    pidgin-with-plugins
    remmina
    shutter
    slack

    ctags
    go_1_13
    nodejs
    shellcheck
    yarn

    kubectx
    qemu
    virtmanager

    ranger
    restic
    terraform-lsp

    # Python
    pipenv
    (python3.withPackages(ps: with ps; [
      isort
      jedi
      jinja2
      pylint
      pep8
      flake8
      pyopenssl
      pytest
      pycodestyle
      pyyaml
      requests
      tox
      xmltodict
    ]))
    # TODO
    #python3Packages.black
    #python3Packages.nose
    #python3Packages.pyflakes
    #python3Packages.pygments
    #python3Packages.pyls-black
    #python3Packages.pyls-isort
    #python3Packages.pytest
    #python3Packages.python-language-server

  ];

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
        "terraform"
        "vi-mode"
        "wd"
      ];
    };

    shellAliases = {
      sl = "exa";
      ls = "exa";
      l = "exa -l";
      la = "exa -la";
      ip = "ip --color=auto";
      tmux="tmux -2";
    };

    sessionVariables = {
      COMPLETION_WAITING_DOTS = "true";
      FZF_TMUX = 1;
      GOPATH = "$HOME/golang";
      KEYTIMEOUT = 1;
      MODE_INDICATOR = " %{$fg_bold[blue]%}%{$reset_color%}";
      PATH = "$PATH:/usr/local/go/bin:$GOPATH/bin";
    };

    initExtra = ''
      ## Custom zsh functions
      source ~/.zsh_functions

      ## Autocompletion for k8s stuff
      source <(kubectl completion zsh)
      source <(helm completion zsh)

      RPS1='$(kube_ps1)$(vi_mode_prompt_info)'
      '';
    };

  home.file.".zsh_functions".source = ./files/zsh_functions;

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;

    defaultOptions = [
      "--border"
    ];
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "19.09";
}
