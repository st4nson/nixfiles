{ config, pkgs, lib, ... }:

{
  # CLI utilities and general-purpose tools
  home.packages = with pkgs; [
    asciidoctor
    asciinema
    bind
    eza
    fd
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
    fastfetch
    nix-index
    openssl
    ranger
    restic
    ripgrep
    saml2aws
    gimme-aws-creds
    silver-searcher
    sshpass
    unzip
    vale
    wget
    yq-go
    zip
  ] ++ lib.optionals pkgs.stdenv.isDarwin [
    terminal-notifier
  ];
}
