{ config, pkgs, ... }:
let
  inherit (pkgs.lib) optionals optionalAttrs optionalString;
  inherit (pkgs.stdenv) isLinux;
in
{
  imports =
    [
      ./home/git.nix
      ./home/go.nix
      ./home/nvim.nix
      ./home/tmux.nix
      ./home/zsh.nix
    ];

  home.username = "sszydo";
  home.stateVersion = "25.05";

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
    cfssl
    eza
    fd
    gnupg
    gopass
    goreleaser
    graphviz
    innoextract
    htop
    http-prompt
    iftop
    ipcalc
    jiq
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
    saml2aws
    silver-searcher
    sshpass
    unzip
    wget
    vale
    wget
    yq-go
    zip

    # Ops - Cloud, Containers & VMs
    #ansible-lint
    #ansible
    awscli2
    colima
    dive
    docker-client
    docker-compose
    docker-credential-helpers
    docker-ls
    #docker-machine
    k2tf
    kubectl
    k9s
    kind
    krew
    kubectx
    kubernetes-helm
    kustomize_3
    skaffold
    #terraform
    terraform-docs
    tflint
    #qemu

    # Programming
    gcc
    gnumake
    nixpkgs-fmt
    nodejs
    pre-commit
    #rnix-lsp
    lua-language-server
    typescript
    typescript-language-server
    shellcheck
    shfmt
    terraform-ls
    universal-ctags
    yarn
    nodePackages.vscode-langservers-extracted
    nodePackages.yaml-language-server
    #playwright-test
    #playwright-driver

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

  home.file."Library/Application Support/com.mitchellh.ghostty/config".source = ./files/ghostty.config;
  home.file.".config/sketchybar".source = ./files/sketchybar;
}
