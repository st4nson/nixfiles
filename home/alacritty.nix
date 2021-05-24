{ pkgs, lib, ...}:

let
  sources = import ../nix/sources.nix;
  pkgs = import sources.nixpkgs {};
in

{
  home.packages = [
    pkgs.alacritty
  ];

  home.file.".alacritty.yml".source = ../files/alacritty.yml;
}
