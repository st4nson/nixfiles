{ pkgs, lib, ...}:

{
  home.packages = with pkgs; [
    #delve
    golangci-lint
    gopls
    gotags
    tinygo
  ];

  programs.go = {
    enable = true;
    package = pkgs.go;

    goBin = "golang/bin";
    goPath = "golang";
  };
}
