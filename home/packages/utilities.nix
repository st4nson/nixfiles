{ config, pkgs, ... }:

{
  # CLI utilities and general-purpose tools
  home.packages = with pkgs; [
    asciidoctor
    bind
    eza
    fd
    gnupg
    gopass
    graphviz
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
    nix-index
    openssl
    ranger
    restic
    ripgrep
    saml2aws
    silver-searcher
    sshpass
    terminal-notifier
    unzip
    vale
    wget
    yq-go
    zip
  ];
}
