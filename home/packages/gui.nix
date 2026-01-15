{ config, pkgs, ... }:

let
  inherit (pkgs.lib) optionals;
  inherit (pkgs.stdenv) isLinux;
in
{
  # GUI applications and desktop environment (Linux-specific)
  imports = [
    ../programs/awesome.nix
    ../programs/taskwarrior.nix
  ];

  home.packages = with pkgs; [] ++ optionals isLinux [
    # System tools
    lshw
    mkpasswd
    virtmanager
    xsel

    # GUI applications
    chromium
    firefox
    icedtea8_web
    keepassxc
    libreoffice
    pidgin-with-plugins
    remmina
    shutter
    slack
  ];
}
