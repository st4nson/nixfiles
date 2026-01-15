{ pkgs, lib, userConfig, ... }:

let
  inherit (pkgs.stdenv) isLinux;
  # Use git/github username for theme directory
  themeUsername = userConfig.aliases.git;
in

lib.mkIf isLinux {
  # AwesomeWM configuration (Linux only)
  xsession = {
    enable = true;
    windowManager.awesome.enable = true;
  };

  # AwesomeWM configuration files
  home.file.".config/awesome/rc.lua".source = ../../dotfiles/awesome/rc.lua;

  home.file.".config/awesome".recursive = true;
  home.file.".config/awesome".source = ../../dotfiles/awesome/awesome-copycats;

  home.file.".config/awesome/lain".recursive = true;
  home.file.".config/awesome/lain".source = ../../dotfiles/awesome/lain;

  home.file.".config/awesome/freedesktop".recursive = true;
  home.file.".config/awesome/freedesktop".source = ../../dotfiles/awesome/freedesktop;

  home.file.".config/awesome/pomodoro".recursive = true;
  home.file.".config/awesome/pomodoro".source = ../../dotfiles/awesome/pomodoro;

  # Theme directory using parameterized username
  home.file.".config/awesome/themes/${themeUsername}".recursive = true;
  home.file.".config/awesome/themes/${themeUsername}".source = ../../dotfiles/awesome/themes/${themeUsername};
}
