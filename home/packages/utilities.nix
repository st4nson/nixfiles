{
  config,
  pkgs,
  lib,
  ...
}:

{
  # CLI utilities and general-purpose tools
  home.packages =
    with pkgs;
    [
      asciidoctor
      asciinema
      bind
      drawio
      eza
      fastfetch
      fd
      git-cliff
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
      poppler
      prek
      ranger
      restic
      ripgrep
      rumdl
      saml2aws
      silver-searcher
      sqlite
      sshpass
      superfile
      typos
      unzip
      vale
      wget
      yq-go
      zip
    ]
    ++ lib.optionals pkgs.stdenv.isDarwin [
      terminal-notifier
    ];
}
