{ config, pkgs, lib, ... }:

{
  # CLI utilities and general-purpose tools
  home.packages = with pkgs; [
    asciidoctor
    asciinema
    bind
    drawio
    eza
    fastfetch
    fd
    gimme-aws-creds
    gnupg
    gopass
    graphviz
    htop
    httpie
    iftop
    ipcalc
    jiq
    jq
    lazygit
    lsof
    luajit
    ncurses
    nix-index
    openssl
    ranger
    restic
    ripgrep
    saml2aws
    silver-searcher
    sshpass
    superfile
    unzip
    vale
    wget
    yq-go
    zip
  ] ++ lib.optionals pkgs.stdenv.isDarwin [
    terminal-notifier
  ];
}
