{ config, pkgs, ... }:

{
  imports =
    [
      ./nvim.nix
      ./zsh.nix
    ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [

    ansible-lint
    ansible

    cfssl
    exa
    fd
    gnupg
    gopass
    htop
    iftop
    ipcalc
    jq
    lshw
    lsof
    mkpasswd
    ranger
    silver-searcher
    sshpass
    taskwarrior
    tmux
    tmuxinator
    ranger
    restic
    unzip
    wget
    zip

    git
    git-crypt
    git-lfs
    git-review

    # GUI
    chromium
    firefox
    icedtea8_web
    keepassxc
    libreoffice
    pidgin-with-plugins
    remmina
    shutter
    slack

    # Containers & VMs
    docker-compose
    docker-ls
    docker-machine
    kubectx
    qemu
    virtmanager

    # Programming
    gnumake
    go
    nodejs
    shellcheck
    universal-ctags
    yarn
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

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;

    defaultOptions = [
      "--border"
    ];
  };

  programs.git = {
    enable = true;
    userName = "Stanisław Szydło";
    userEmail = "st4nson@gmail.com";
  };

  programs.tmux = {
    enable = true;

    terminal = "st-256color";
    keyMode = "vi";
    baseIndex = 0;
    escapeTime = 0;
    historyLimit = 50000;
    clock24 = true;

    aggressiveResize = true;
    secureSocket = false;
    customPaneNavigationAndResize = true;

    extraConfig = ''
      set -g mouse on           # mouse support

      # stop confusion while spliting windows
      bind | split-window -h
      bind - split-window -v
      unbind %
      unbind '"'

      # Sync panes
      bind e setw synchronize-panes on
      bind E setw synchronize-panes off
    '';

    plugins = with pkgs; [
      tmuxPlugins.yank
      tmuxPlugins.copycat
      tmuxPlugins.prefix-highlight

      # TODO
      #tmuxPlugins.resurrect
      #tmuxPlugins.continuum
      #tmuxPlugins.kube-tmux
      #tmuxPlugins.nord

    ];

    tmuxinator.enable = true;
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "20.03";
}
