{ pkgs, lib, ... }:

let
  sources = import ../nix/sources.nix;
  pkgs = import sources.nixpkgs {};
in

{
  home.packages = with pkgs; [
    git-crypt
    git-lfs
    git-review
  ];

  programs.git = {
    enable = true;
    userName = "Stanisław Szydło";
    userEmail = "st4nson@gmail.com";
  };
}
