{ config, pkgs, ... }:

{
  imports =
  [
    ./hardware-configuration.nix
    ./../transparent-proxy.nix
    ./../common-config.nix
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

  # Setup display and window maanger
  services.xserver = {
    videoDrivers = [ "intel" ];
  };

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  hardware.bluetooth.extraConfig = ''
  [General]
  Disable=Socket
  Disable=Headset
  Enable=Media,Source,Sink,Gateway
  AutoConnect=true
  load-module module-switch-on-connect
  ControllerMode = bredr
'';

  # Enable touchpad support.
  services.xserver.libinput.enable = true;

  hardware.opengl.extraPackages = [ pkgs.vaapiIntel ];

  nixpkgs.config.allowUnfree = true;

  # VMs and Containers
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
