{ pkgs, lib, ...}:

{
  home.packages = [
    pkgs.alacritty
  ];

  home.file.".alacritty.yml".source = ../files/alacritty.yml;
}
