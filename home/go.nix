{ pkgs, lib, ...}:

let
  sources = import ../nix/sources.nix;
  pkgs = import sources.nixpkgs {};
in

{
  home.packages = with pkgs; [
    delve
    golangci-lint
    gopls
    gotags
  ];

  programs.go = {
    enable = true;
    package = pkgs.go;

    goBin = "golang/bin";
    goPath = "golang";
  };
}
