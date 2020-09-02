{ pkgs, lib, ... }:

let
  inherit (lib) optionals optionalAttrs optionalString;
  inherit (pkgs.stdenv) isLinux;
in

{
  imports =
    [
      ./nvim.nix
      ./tmux.nix
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
    lsof
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

    # Containers & VMs
    docker-compose
    docker-ls
    docker-machine
    kubectx
    qemu

    # Programming
    gnumake
    nixpkgs-fmt
    nodejs
    rnix-lsp
    shellcheck
    shfmt
    terraform-lsp
    universal-ctags
    yarn

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

  ] ++ optionals isLinux [
    lshw
    mkpasswd
    virtmanager

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

  programs.go = {
    enable = true;

    goBin = "golang/bin";
    goPath = "golang";
  };

  # AwesomeWM configuration
  xsession = {
    enable = true;
    windowManager.awesome.enable = true;
  };
  home.file.".config/awesome/rc.lua".source = ./files/awesome/rc.lua;

  home.file.".config/awesome".recursive = true;
  home.file.".config/awesome".source = ./files/awesome/awesome-copycats;

  home.file.".config/awesome/lain".recursive = true;
  home.file.".config/awesome/lain".source = ./files/awesome/lain;

  home.file.".config/awesome/freedesktop".recursive = true;
  home.file.".config/awesome/freedesktop".source = ./files/awesome/freedesktop;
  home.file.".config/awesome/pomodoro".recursive = true;
  home.file.".config/awesome/pomodoro".source = ./files/awesome/pomodoro;

  home.file.".config/awesome/themes/st4nson".recursive = true;
  home.file.".config/awesome/themes/st4nson".source = ./files/awesome/themes/st4nson;

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
