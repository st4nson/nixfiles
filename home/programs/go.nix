{ config, pkgs, lib, ...}:

{
  home.packages = with pkgs; [
    delve
    golangci-lint
    golangci-lint-langserver
    gopls
    gotags
    tinygo
  ];

  programs.go = {
    enable = false;
    package = pkgs.go;  # Use latest stable Go version

    env.goBin = config.home.homeDirectory . "golang/bin";
    env.goPath = config.home.homeDirectory . "golang";
  };
}
