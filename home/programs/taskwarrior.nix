{ pkgs, lib, ... }:

{
  # Taskwarrior - Task management tool
  programs.taskwarrior = {
    enable = true;
    colorTheme = "dark-violets-256";
    dataLocation = "~/.task";
  };
}
