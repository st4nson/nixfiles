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
    extraConfig = {
      url = {
        "ssh://git@github.com" = {
          insteadOf = "https://github.com"; };
        };
      url = {
        "git@github.com:" = {
          insteadOf = "github.com/"; };
        };
    };
  };
}
