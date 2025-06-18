{ pkgs, lib, ...}:

{
  home.packages = with pkgs; [
    delve
    golangci-lint
    golangci-lint-langserver
    gopls
    gotags
    tinygo
  ];

  programs.go = {
    enable = true;
    package = pkgs.go_1_22;

    goBin = "golang/bin";
    goPath = "golang";
  };
}
