{ config, pkgs, lib, ...}:

{
  home.packages = with pkgs; [
    ollama
  ];

  services.ollama = {
    enable = true;
    acceleration = false;
  };
}
