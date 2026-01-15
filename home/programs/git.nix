{ pkgs, lib, userConfig, ... }:

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
    userName = userConfig.fullName;
    userEmail = userConfig.email;
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
