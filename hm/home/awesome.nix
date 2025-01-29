{ pkgs, lib, ... }:

let
  inherit (pkgs.stdenv) isLinux;
in

lib.mkIf isLinux {
   #AwesomeWM configuration
  xsession = {
    enable = true;
    windowManager.awesome.enable = true;
  };
  home.file.".config/awesome/rc.lua".source = ../files/awesome/rc.lua;

  home.file.".config/awesome".recursive = true;
  home.file.".config/awesome".source = ../files/awesome/awesome-copycats;

  home.file.".config/awesome/lain".recursive = true;
  home.file.".config/awesome/lain".source = ../files/awesome/lain;

  home.file.".config/awesome/freedesktop".recursive = true;
  home.file.".config/awesome/freedesktop".source = ../files/awesome/freedesktop;
  home.file.".config/awesome/pomodoro".recursive = true;
  home.file.".config/awesome/pomodoro".source = ../files/awesome/pomodoro;

  home.file.".config/awesome/themes/st4nson".recursive = true;
  home.file.".config/awesome/themes/st4nson".source = ../files/awesome/themes/st4nson;
}
