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
    package = pkgs.go_1_17;

    goBin = "golang/bin";
    goPath = "golang";
  };
}
