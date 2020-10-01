{ pkgs, lib, ...}:
{
  programs.bat = {
    enable = true;
    config = {
      theme = "Nord";
    };
  };
}
