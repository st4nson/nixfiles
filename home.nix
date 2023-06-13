{ config, pkgs, ... }:

let
  inherit (pkgs.lib) optionals optionalAttrs optionalString;
  inherit (pkgs.stdenv) isLinux;
in

{
  imports =
    [
      ./home/alacritty.nix
      #./home/awesome.nix
      ./home/git.nix
      ./home/go.nix
      ./home/nvim.nix
      ./home/taskwarrior.nix
      ./home/tmux.nix
      ./home/zsh.nix
    ];

  nixpkgs.overlays = [
    (self: super: {
      golangci-lint = super.golangci-lint.override {
        # Override https://github.com/NixOS/nixpkgs/pull/166801 which changed this
        # to buildGo118Module because it does not build on Darwin.
        buildGoModule = super.buildGoModule;
      };
    })
  ];

  programs = {
    home-manager.enable = true;

    bat = {
      enable = true;
      config = {
        theme = "Catppuccin-macchiato";
      };
    };

    direnv = {
      enable = true;
      enableZshIntegration = true;
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
      package = pkgs.fzf;

      defaultOptions = [
        "--border"
      ];
    };
  };

  home.packages = with pkgs; [
    asciidoctor
    bind
    cachix
    cfssl
    exa
    fd
    gnupg
    gopass
    graphviz
    htop
    http-prompt
    iftop
    ipcalc
    jq
    lazygit
    lsof
    luajit
    ncurses
    neofetch
    #neovim-remote
    nix-index
    openssl
    ranger
    restic
    ripgrep
    silver-searcher
    sshpass
    unzip
    wget
    yq-go
    zip

    # Ops - Cloud, Containers & VMs
    #ansible-lint
    #ansible
    awscli2
    dive
    docker-compose
    docker-ls
    docker-machine
    k2tf
    k9s
    kind
    krew
    kubectx
    kubernetes-helm
    kustomize_3
    skaffold
    terraform
    terraform-docs
    tflint
    #qemu

    # Programming
    gcc
    gnumake
    nixpkgs-fmt
    nodejs
    pre-commit
    rnix-lsp
    shellcheck
    shfmt
    terraform-ls
    universal-ctags
    yarn
    nodePackages.vscode-langservers-extracted
    nodePackages.yaml-language-server

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
    xsel

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
}
