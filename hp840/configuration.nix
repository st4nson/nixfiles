{ config, pkgs, ... }:

{
  imports =
  [
    ./hardware-configuration.nix
    ./../transparent-proxy.nix
    ./../common-config.nix
    ./../custom-certs.nix
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
    };

    cleanTmpDir = true;
  };

  # Services to enable:
  services.openssh.enable = true;

  services.printing.enable = true;
  services.printing.drivers = [ pkgs.hplip ];

  # Networking setup
  networking = {
    hostName = "sszydlo-mobl";
    firewall.trustedInterfaces = [ "docker0" ];
    dhcpcd.denyInterfaces = [ "enp0s31f6" ];
    wireless.enable = true;
    enableIPv6 = false;
  };

  # Setup hardware (video & audio)
  services.xserver = {
    videoDrivers = [ "intel" ];
  };

  hardware.opengl.extraPackages = [ pkgs.vaapiIntel ];

  services.redshift = {
    enable = true;
    brightness.night = "0.80";
  };

  location.provider = "manual";
  location.latitude = 54.37;
  location.longitude = 18.63;

  # Bluetooth
  services.blueman.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  hardware.bluetooth.extraConfig = ''
  [General]
  Disable=Socket
  Disable=Headset
  Enable=Media,Source,Sink,Gateway
  AutoConnect=true
  #load-module module-switch-on-connect
  ControllerMode = bredr
'';

  # Enable touchpad support.
  services.xserver.libinput.enable = true;

  # VMs and Containers
  nixpkgs.config.allowUnfree = true; # needed for 'enableExtensionPack'

  virtualisation = {
    virtualbox.host.enable = true;
    virtualbox.host.enableExtensionPack = true;
  };

  # User account
  users.extraUsers.st4nson = {
    extraGroups  = [
      "vboxusers"
    ];
  };

}
