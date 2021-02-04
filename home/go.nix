{ pkgs, lib, ...}:

{
  home.packages = with pkgs; [
    delve
    golangci-lint
    gopls
    gotags
  ];

  programs.go = {
    enable = true;

    goBin = "golang/bin";
    goPath = "golang";
  };
}
