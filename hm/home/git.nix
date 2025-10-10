{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    git-crypt
    git-lfs
    git-review
    gh
    gh-copilot
  ];

  programs.git = {
    enable = true;
    lfs.enable = false;
    userName = "Stanisław Szydło";
    userEmail = "stanislaw.szydlo@nike.com";
    #userEmail = "st4nson@gmail.com";
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
