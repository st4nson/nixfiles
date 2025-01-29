{ pkgs, lib, ... }:

{
  programs.taskwarrior = {
    enable = true;
    colorTheme = "dark-violets-256";
    dataLocation = "~/.task";
  };
}
