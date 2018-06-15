{ config, pkgs, ... }:

{
  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "pl";
    defaultLocale = "en_US.UTF-8";
  };

  # Fonts
  fonts.fonts = with pkgs; [
    nerdfonts
    dejavu_fonts
  ];

  # Set your time zone.
  time.timeZone = "Europe/Warsaw";

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    bind
    chromium
    file
    git
    git-crypt
    git-lfs
    git-review
    gnumake
    htop
    jq
    lshw
    lsof
    mkpasswd
    openssl
    openvpn
    pciutils
    python27
    python36
    remmina
    shutter
    silver-searcher
    st
    telnet
    tmux
    tmuxinator
    tree
    unzip
    usbutils
    vagrant
    vim
    wget
    xclip
    xscreensaver
    zsh
  ];

  # Custom pkgs config
  nixpkgs.config = {
    st.patches = [ ./st-nord.patch ];
  };

  programs.zsh.enable = true;
  programs.ssh.startAgent = true;
  programs.vim.defaultEditor = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Setup display and window maanger
  services.xserver = {
    enable = true;
    layout = "pl";

    displayManager = {
      # Start xscreensaver on startup
      sessionCommands = "xscreensaver -no-splash &";
      # Setup Slim
      slim = {
        enable = true;
        theme = pkgs.fetchurl {
          url = "https://github.com/edwtjo/nixos-black-theme/archive/v1.0.tar.gz";
          sha256 = "13bm7k3p6k7yq47nba08bn48cfv536k4ipnwwp1q1l2ydlp85r9d";
        };
      };
    };

    # AwesomeWM
    windowManager.awesome.enable = true;
  };

  # VMs and Containers
  virtualisation = {
    docker.enable = true;
  };

  # User account
  users.extraUsers.st4nson = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups  = [
      "audio"
      "wheel"
      "docker"
    ];
  };

  # The NixOS release
  system.stateVersion = "18.03";
}