{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    git-crypt
    git-lfs
    git-review
    gh
  ];

  programs.git = {
    enable = true;
    userName = "Stanisław Szydło";
    userEmail = "st4nson@gmail.com";
  };
}
