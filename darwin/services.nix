# macOS Services Configuration

{ config, pkgs, ... }:

{
  # Yabai - Tiling window manager for macOS
  services.yabai = {
    enable = true;
    package = pkgs.yabai;

    enableScriptingAddition = false;

    config = {
      # Reserve space for status bar (40px at top)
      external_bar               = "all:40:0";

      # Focus behavior
      mouse_follows_focus        = "on";   # Move mouse when changing focus
      focus_follows_mouse        = "off";  # Don't change focus on mouse hover

      # Window placement and appearance
      window_placement           = "second_child";  # New windows go to the right/bottom
      window_topmost             = "off";           # Don't keep windows on top
      window_shadow              = "float";         # Show shadows only for floating windows
      window_opacity             = "on";
      window_opacity_duration    = "0.1";           # Transition duration in seconds

      # Window opacity values (1.0 = opaque)
      active_window_opacity      = "1.0";
      normal_window_opacity      = "1.0";

      # Window borders for visual feedback
      window_border              = "on";
      window_border_width        = 1;

      # Border colors
      active_window_border_color = "0xff5cafb0";    # Cyan for active window
      normal_window_border_color = "0xff505050";    # Gray for inactive windows
      insert_window_border_color = "0xffd75f5f";    # Red for insert mode

      # Layout settings
      split_ratio                = "0.50";  # New splits take 50% of space
      auto_balance               = "off";   # Don't automatically rebalance windows

      # Mouse interactions
      mouse_modifier             = "cmd ";      # Hold CMD to move/resize windows
      mouse_action1              = "move";      # CMD+Left click to move
      mouse_action2              = "resize";    # CMD+Right click to resize
      mouse_drop_action          = "swap";      # Swap windows on drop

      # Layout and spacing
      layout                     = "bsp";       # Binary Space Partitioning layout
      top_padding                = 10;
      bottom_padding             = 10;
      left_padding               = 10;
      right_padding              = 10;
      window_gap                 = 5;           # Gap between windows
    };

    # Additional configuration and window rules
    # These rules exclude certain apps from tiling
    extraConfig = ''
      # System apps that should float
      yabai -m rule --add app='System Preferences' manage=off
      yabai -m rule --add app="^Ustawienia systemowe$" manage=off  # Polish locale

      # VPN client - floating for ease of use
      yabai -m rule --add app="^Cisco AnyConnect Secure Mobility Client$" manage=off

      # Audio and design tools - better floating
      yabai -m rule --add app='^eqMac$' manage=off
      yabai -m rule --add app='^SketchUp$' manage=off
    '';
  };

  # Sketchybar - Modern, customizable status bar
  services.sketchybar = {
    enable = true;
    package = pkgs.sketchybar;
  };

  # Spacebar - Simple status bar (disabled in favor of Sketchybar)
  # Kept for reference
  services.spacebar = {
    enable = false;
    package = pkgs.spacebar;
    config = {
      # Layout
      position            = "top";
      height              = 28;
      spacing_left        = 25;
      spacing_right       = 15;

      # Fonts (requires Hack Nerd Font)
      text_font           = ''"Hack Nerd Font:Regular:14.0"'';
      icon_font           = ''"Hack Nerd Font:Regular:12.0"'';

      # Colors (0xAARRGGBB format)
      background_color    = "0xff121212";  # Dark background
      foreground_color    = "0xff5cafb0";  # Cyan text
      space_icon_color    = "0xff458588";  # Blue for workspace icons
      power_icon_color    = "0xffcd950c";  # Yellow for power
      battery_icon_color  = "0xffd75f5f";  # Red for battery
      dnd_icon_color      = "0xffa8a8a8";  # Gray for DND
      clock_icon_color    = "0xffa8a8a8";  # Gray for clock

      # Icons and format
      space_icon_strip    = "I II III IV V VI VII VIII IX X";  # Workspace numbers
      power_icon_strip    = "🔋 ⚡";
      space_icon          = "";
      clock_icon          = "🕜";
      dnd_icon            = "";
      clock_format        = ''"%d/%m/%y %R"'';  # DD/MM/YY HH:MM

      # Custom command for pomodoro timer
      right_shell         = "on";
      right_shell_command = ''"~/bin/pomodoro status -f \"🍅 %!r 🍅\""'';
    };
  };

  # SKHD - Simple Hotkey Daemon
  # Provides global keyboard shortcuts for window management and app launching
  services.skhd = {
    enable = true;
    package = pkgs.skhd;
    skhdConfig = ''
      # Application launching
      # CMD+Return: Open new terminal (Ghostty)
      cmd - return : "open -n /Applications/Ghostty.app"

      # CMD+Q: Open Chrome in single-instance debugging mode
      cmd - q : "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" --single-instance -d

      # Window focus (Vi-style navigation)
      # Left Alt + h/j/k/l: Focus window in that direction
      lalt - h : yabai -m window --focus west
      lalt - j : yabai -m window --focus south
      lalt - k : yabai -m window --focus north
      lalt - l : yabai -m window --focus east

      # Window focus (cyclic)
      # CMD+J/K: Focus previous/next window
      cmd - j : yabai -m window --focus prev
      cmd - k : yabai -m window --focus next

      # Window management
      # Left Alt+T: Toggle floating mode and center window
      # Grid format: rows:cols:x:y:width:height (creates 2x2 centered window)
      lalt - t : yabai -m window --toggle float;\
                 yabai -m window --grid 4:4:1:1:2:2

      # Left Alt+D: Toggle zoom (expand window to fill parent container)
      lalt - d : yabai -m window --toggle zoom-parent
    '';
  };
}
