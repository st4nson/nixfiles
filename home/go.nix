{ pkgs, lib, ...}:

{
  home.packages = with pkgs; [
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
