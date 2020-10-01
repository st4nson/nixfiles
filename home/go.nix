{ pkgs, lib, ...}:

{
  home.packages = with pkgs; [
    gopls
    golangci-lint
  ];

  programs.go = {
    enable = true;

    goBin = "golang/bin";
    goPath = "golang";
  };
}
