{ config, pkgs, ... }:

{
  imports =
  [
    ./hardware-configuration.nix
    ./transparent-proxy.nix
  ];

  # Boot options
  boot = {
    initrd = {
      availableKernelModules =  [
        "ext4"
        "hid_generic"
        "hid_microsoft"
      ];

      luks.devices = [
        {
          name = "luksroot";
          device = "/dev/sda2";
          preLVM = true;
          allowDiscards = true;
        }
      ];
    };

    # Use the systemd-boot EFI boot loader.
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;

      grub = {
        #configurationName = "Stable 1.2.3"
        configurationLimit = 25;
      };
    };

    cleanTmpDir = true;
  };

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

  # Services to enable:
  services.openssh.enable = true;

  # Networking setup
  networking = {
    hostName = "st4nson-dev";
    dhcpcd.denyInterfaces = [ "enp3s0" ];
    firewall.trustedInterfaces = [ "docker0" ];
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Setup display and window maanger
  services.xserver = {
    enable = true;
    videoDrivers = [ "intel" ];
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

  hardware.opengl.extraPackages = [ pkgs.vaapiIntel ];

  # VMs and Containers
  virtualisation = {
    docker.enable = true;
    virtualbox.host.enable = true;
  };

  # User account
  users.extraUsers.st4nson = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups  = [
      "wheel"
      "docker"
      "vboxusers"
    ];
  };

  # The NixOS release
  system.stateVersion = "18.03";
}
