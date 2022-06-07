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
        theme = "Nord";
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

  home.packages = with pkgs; [

    asciidoctor
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
    luajit
    lsof
    neofetch
    #neovim-remote
    nix-index
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
    terraform
    terraform-docs
    tflint
    #qemu

    # Programming
    gnumake
    nixpkgs-fmt
    nodejs
    #pre-commit  # TODO broken - dotnet ?
    rnix-lsp
    shellcheck
    shfmt
    terraform-ls
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
    keepassxc
    libreoffice
    pidgin-with-plugins
    remmina
    shutter
    slack
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";
}
