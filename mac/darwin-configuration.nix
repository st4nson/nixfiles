{ config, pkgs, ... }:

{
  system.defaults.NSGlobalDomain._HIHideMenuBar = true;
  system.defaults.dock.autohide = true;
  system.defaults.dock.orientation = "bottom";
  system.defaults.dock.show-recents = false;
  system.defaults.dock.tilesize = 32;
  system.defaults.spaces.spans-displays = false;

  # List packages installed in system profile. To search by name, run:
  environment.systemPackages = with pkgs; [
    alacritty
    vim
  ];

  fonts.enableFontDir = true;
  fonts.fonts = with pkgs; [
    nerdfonts
  ];

  environment.variables = {
    EDITOR = "vim";
  };

  services.yabai = {
    enable = true;
    package = pkgs.yabai;
    enableScriptingAddition = false;
    config = {
      external_bar               = "all:28:0";

      mouse_follows_focus        =  "on";
      focus_follows_mouse        =  "off";

      window_placement           =  "second_child";
      window_topmost             =  "off";
      window_shadow              =  "float";
      window_opacity             =  "on";
      window_opacity_duration    =  "0.1";

      active_window_opacity      =  "1.0";
      normal_window_opacity      =  "1.0";

      window_border              =   "on";
      window_border_width        =   1;

      active_window_border_color =  "0xff5cafb0";
      normal_window_border_color =  "0xff505050";
      insert_window_border_color =  "0xffd75f5f";

      split_ratio                =   "0.50";
      auto_balance               =   "off";

      mouse_modifier             =   "cmd ";
      mouse_action1              =   "move";
      mouse_action2              =   "resize";
      mouse_drop_action          =   "swap";

      layout                     =   "bsp";
      top_padding                =   0;
      bottom_padding             =   0;
      left_padding               =   0;
      right_padding              =   0;
      window_gap                 =   1;
    };

    extraConfig = ''
      # rules
      yabai -m rule --add app='System Preferences' manage=off
      yabai -m rule --add app="^Cisco AnyConnect Secure Mobility Client$" manage=off
    '';
  };

  services.spacebar = {
    enable = true;
    package = pkgs.spacebar;
    config = {
      position           = "top";
      height             = 28;
      spacing_left       = 25;
      spacing_right      = 15;
      text_font          = ''"Hack Nerd Font:Regular:14.0"'';
      icon_font          = ''"Hack Nerd Font:Regular:12.0"'';
      background_color   = "0xff121212";
      foreground_color   = "0xff5cafb0";
      space_icon_color   = "0xff458588";
      power_icon_color   = "0xffcd950c";
      battery_icon_color = "0xffd75f5f";
      dnd_icon_color     = "0xffa8a8a8";
      clock_icon_color   = "0xffa8a8a8";
      space_icon_strip   = "I II III IV V VI VII VIII IX X";
      power_icon_strip   = " ";
      space_icon         = "";
      clock_icon         = "";
      dnd_icon           = "";
      clock_format       = ''"%d/%m/%y %R"'';
    };
  };

  services.skhd = {
    enable = true;
    package = pkgs.skhd;
    skhdConfig = ''
      # open terminal
      cmd - return : /Applications/NixManualApps/Alacritty.app/Contents/MacOS/alacritty
      cmd - q : "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" --single-instance -d

      # focus window
      lalt - h : yabai -m window --focus west
      lalt - j : yabai -m window --focus south
      lalt - k : yabai -m window --focus north
      lalt - l : yabai -m window --focus east

      cmd - j : yabai -m window --focus prev
      cmd - k : yabai -m window --focus next

      # float / unfloat window and center on screen
      lalt - t : yabai -m window --toggle float;\
                 yabai -m window --grid 4:4:1:1:2:2

      # toggle window zoom
      lalt - d : yabai -m window --toggle zoom-parent
    '';
  };

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  programs.zsh.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
