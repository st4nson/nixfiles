{ pkgs, lib, ... }:

let
  inherit (lib) optionals optionalAttrs optionalString;
  inherit (pkgs.stdenv) isLinux;
in

{
  imports =
    [
      ./home/awesome.nix
      ./home/nvim.nix
      ./home/tmux.nix
      ./home/zsh.nix
    ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [

    ansible-lint
    ansible

    alacritty
    awscli
    cfssl
    exa
    fd
    gnupg
    gopass
    htop
    iftop
    ipcalc
    jq
    keepassxc
    lsof
    ranger
    ranger
    restic
    silver-searcher
    sshpass
    taskwarrior
    tmux
    tmuxinator
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
    gopls
    nixpkgs-fmt
    nodejs
    rnix-lsp
    shellcheck
    shfmt
    terraform-lsp
    universal-ctags
    yarn

    # Python TODO
    #pipenv
    #(python3.withPackages(ps: with ps; [
    #  isort
    #  jedi
    #  jinja2
    #  pylint
    #  pep8
    #  flake8
    #  pyopenssl
    #  pytest
    #  pycodestyle
    #  pyyaml
    #  requests
    #  tox
    #  xmltodict
    #]))
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
    libreoffice
    pidgin-with-plugins
    remmina
    shutter
    slack
  ];

  programs.bat = {
    enable = true;
    config = {
      theme = "Nord";
    };
  };

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

  home.file.".alacritty.yml".source = ./files/alacritty.yml;

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
