{ pkgs, lib, ...}:

{
  home.packages = with pkgs; [
    gopls
  ];

  programs.go = {
    enable = true;

    goBin = "golang/bin";
    goPath = "golang";
  };
}
