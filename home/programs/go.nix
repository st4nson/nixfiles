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
    enable = true;
    package = pkgs.go;  # Use latest stable Go version

    env = {
      GOPATH = [ "${config.home.homeDirectory}/golang" ];
      GOBIN = "${config.home.homeDirectory}/golang/bin";
    };
  };
}
