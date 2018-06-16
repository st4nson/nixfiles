{ config, pkgs, ... }:

{
  imports =
  [
    ./hardware-configuration.nix
#   ./transparent-proxy.nix
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

      grub = {
        configurationLimit = 25;
      };
    };

    cleanTmpDir = true;
  };

  # Services to enable:
  services.openssh.enable = true;

  # Networking setup
  networking = {
    hostName = "st4nson-mobl";
    firewall.trustedInterfaces = [ "docker0" ];
    wireless.enable = true;
  };

  # Setup display and window maanger
  services.xserver = {
    videoDrivers = [ "intel" ];
  };

  # Enable touchpad support.
  services.xserver.libinput.enable = true;

  hardware.opengl.extraPackages = [ pkgs.vaapiIntel ];

  # VMs and Containers
  virtualisation = {
    virtualbox.host.enable = true;
  };

  # User account
  users.extraUsers.st4nson = {
    extraGroups  = [
      "vboxusers"
    ];
  };

}
