{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./../common-config.nix
      ./../transparent-proxy.nix
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

      grub = {
        #configurationName = "Stable 1.2.3"
        configurationLimit = 25;
      };
    };

    cleanTmpDir = true;
  };

  # Services to enable:
  services.openssh.enable = true;
  services.ntp.enable = true;

  # Networking setup
  networking = {
    hostName = "st4nson-dev";
    dhcpcd.denyInterfaces = [ "enp3s0" ];
    firewall.trustedInterfaces = [ "docker0" ];

    hosts = { };
  };

  # Setup hardware (video & audio)
  services.xserver = {
    videoDrivers = [ "intel" ];
  };

  hardware.opengl.extraPackages = [ pkgs.vaapiIntel ];
  hardware.opengl.driSupport32Bit = true;
  hardware.pulseaudio.support32Bit = true;

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

  # VMs and Containers
  nixpkgs.config.allowUnfree = true; # needed for 'enableExtensionPack'

  virtualisation = {
    virtualbox.host.enable = true;
    virtualbox.host.enableExtensionPack = true;
    libvirtd.enable = true;
    libvirtd.extraConfig= ''
    user = "st4nson"
    group = "users"
    dynamic_ownership = 1
    '';
  };

  # User account
  users.extraUsers.st4nson = {
    extraGroups  = [
      "vboxusers"
      "libvirtd"
    ];
  };
}
